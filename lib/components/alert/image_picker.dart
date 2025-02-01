import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todomaker/components/loading/loading.dart';

class ImagePickerDialog extends HookConsumerWidget {
  const ImagePickerDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final imagePicker = ImagePicker();

    return AlertDialog(
      content: Loading(
        isLoading: isLoading.value,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('カメラ'),
              leading: const Icon(Icons.photo_camera),
              onTap: () async {
                final XFile? photo = await imagePicker.pickImage(source: ImageSource.camera);

                if (photo != null) {
                  if (context.mounted) {
                    Navigator.of(context).pop(photo);
                  }
                }
              },
            ),
            ListTile(
              title: const Text('フォトライブラリ'),
              leading: const Icon(Icons.photo_album),
              onTap: () async {
                final XFile? photo = await imagePicker.pickImage(source: ImageSource.gallery);
                if (photo != null) {
                  if (context.mounted) {
                    Navigator.of(context).pop(photo);
                  }
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}

Future<XFile?> showImagePickerDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => const ImagePickerDialog(),
  );
}
