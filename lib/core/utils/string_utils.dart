// lib/core/utils/string_utils.dart
import 'package:flutter/material.dart';

class AppStringUtils {
  // ตัดข้อความตามความยาวที่กำหนด
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // แปลงข้อความเป็นตัวใหญ่เฉพาะตัวแรก
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  // ตรวจสอบว่าเป็น email ที่ถูกต้อง
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // ตรวจสอบว่าเป็นเบอร์โทรที่ถูกต้อง
  static bool isValidPhone(String phone) {
    return RegExp(r'^0[0-9]{9}$').hasMatch(phone);
  }
}
