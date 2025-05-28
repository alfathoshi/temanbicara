import 'dart:io';
import 'package:flutter/services.dart';

class NativeShare {
  static const MethodChannel _channel = MethodChannel('native_share');

  static Future<void> shareFile(String filePath) async {
    if (!Platform.isAndroid) return;
    try {
      await _channel.invokeMethod('shareFile', {'filePath': filePath});
    } catch (e) {
      throw 'Failed to share file: $e';
    }
  }
}
