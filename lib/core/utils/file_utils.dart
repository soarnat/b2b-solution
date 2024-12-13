// lib/core/utils/file_utils.dart
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

class AppFileUtils {
  // หาประเภทของไฟล์
  static String? getMimeType(String filepath) {
    return lookupMimeType(filepath);
  }

  // หานามสกุลไฟล์
  static String getFileExtension(String filepath) {
    return path.extension(filepath);
  }

  // แปลงขนาดไฟล์เป็นหน่วยที่อ่านง่าย
  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }

  // บันทึกไฟล์ลงในเครื่อง
  static Future<File> saveFile(List<int> bytes, String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final filepath = path.join(directory.path, filename);
    return File(filepath).writeAsBytes(bytes);
  }
}
