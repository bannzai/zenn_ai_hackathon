import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart';

Future<Uint8List> convertToJPEGImage(File file) async {
  //1. Decode the image.
  final image = decodeImage(await file.readAsBytes());
  if (image == null) {
    throw Exception('Failed to decode image');
  }
  final resizedImageBytes = encodeJpg(image, quality: 100);
  return resizedImageBytes;
}

Future<String> base64CompressImage(File file) async {
  try {
    //1. Decode the image.
    final image = decodeImage(await file.readAsBytes());

    if (image == null) {
      throw Exception('Failed to decode image');
    }

    // 2. Resize the image (adjust dimensions as needed)
    // Get image dimensions
    const maxSize = 1000;
    final width = image.width;
    final height = image.height;

    // Calculate scaling factor to maintain aspect ratio
    double scaleFactor;
    if (width > height) {
      scaleFactor = maxSize / width;
    } else {
      scaleFactor = maxSize / height;
    }

    // Resize the image (adjust dimensions as needed)
    final resizedImage = copyResize(
      image,
      width: (width * scaleFactor).round(),
      height: (height * scaleFactor).round(),
    );

    // 3. Encode the resized image to base64
    final resizedImageBytes = encodeJpg(resizedImage, quality: 100); //or img.encodeJpg(resizedImage, quality: 85);
    final base64Image = base64Encode(resizedImageBytes);

    return base64Image;
  } catch (e) {
    debugPrint('Error resizing image: $e');
    throw Exception('Error resizing image: $e');
  }
}

String mimeType(File file) {
  final extension = file.path.split('.').lastOrNull;
  switch (extension) {
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    default:
      return 'image/jpeg'; // デフォルト
  }
}
