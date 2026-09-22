import 'dart:io';
import 'package:flutter/foundation.dart';

Future<File> saveUint8ListToImage(Uint8List imageData, String path) async {
  try {
    File file = await File(path).create();
    return await file.writeAsBytes(imageData);
  }
  catch(e) {
    throw Exception('Cannot save image!. Error: $e');
  }
}

({String extension, int offset})? getUint8ListImageExtension(Uint8List bytes) {
  if (bytes.length < 3) {
    return null;
  }

  const int maxScan = 8192;
  final int limit = bytes.length < maxScan ? bytes.length : maxScan;

  for (int i = 0; i <= limit - 3; i++) {
    // JPEG
    if (bytes[i] == 0xFF && bytes[i + 1] == 0xD8 && bytes[i + 2] == 0xFF) {
      return (extension: 'jpg', offset: i);
    }

    // PNG
    if (i <= limit - 4 &&
        bytes[i] == 0x89 &&
        bytes[i + 1] == 0x50 &&
        bytes[i + 2] == 0x4E &&
        bytes[i + 3] == 0x47) {
      return (extension: 'png', offset: i);
    }
    // GIF
    if (bytes[i] == 0x47 &&
        bytes[i + 1] == 0x49 &&
        bytes[i + 2] == 0x46) {
      return (extension: 'gif', offset: i);
    }
    // WEBP
    if (i <= limit - 12 &&
        bytes[i] == 0x52 &&
        bytes[i + 1] == 0x49 &&
        bytes[i + 2] == 0x46 &&
        bytes[i + 3] == 0x46 &&
        bytes[i + 8] == 0x57 &&
        bytes[i + 9] == 0x45 &&
        bytes[i + 10] == 0x42 &&
        bytes[i + 11] == 0x50) {
      return (extension: 'webp', offset: i);
    }
  }

  return null; // Unknown format
}