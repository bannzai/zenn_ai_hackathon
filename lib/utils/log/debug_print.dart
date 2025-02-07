import 'package:flutter/foundation.dart';

void overrideDebugPrint() {
  debugPrint = _debugPrint;
}

void _debugPrint(String? message, {int? wrapWidth}) {
  if (kDebugMode) {
    if (message == null) {
      print('null');
    } else {
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      // ignore: avoid_print
      pattern.allMatches(message).forEach((match) => print('[APP:DEBUG] ${match.group(0)}'));
    }
  }
}
