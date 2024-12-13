// lib/core/utils/validation_utils.dart

import 'package:flutter/material.dart'; // สำหรับ String? type
import 'string_utils.dart'; // สำหรับเรียกใช้ isValidEmail, isValidPhone

class AppValidationUtils {
  // Validate required field
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอก$fieldName';
    }
    return null;
  }

  // Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกอีเมล';
    }
    if (!AppStringUtils.isValidEmail(value)) {
      return 'อีเมลไม่ถูกต้อง';
    }
    return null;
  }

  // Validate phone number format
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกเบอร์โทรศัพท์';
    }
    if (!AppStringUtils.isValidPhone(value)) {
      return 'เบอร์โทรศัพท์ไม่ถูกต้อง';
    }
    return null;
  }

  // เพิ่มฟังก์ชัน validation อื่นๆ ที่มีประโยชน์
  // Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกรหัสผ่าน';
    }
    if (value.length < 8) {
      return 'รหัสผ่านต้องมีความยาวอย่างน้อย 8 ตัวอักษร';
    }
    return null;
  }

  // Validate confirm password
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกยืนยันรหัสผ่าน';
    }
    if (value != password) {
      return 'รหัสผ่านไม่ตรงกัน';
    }
    return null;
  }

  // Validate ID card
  static String? validateIdCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกเลขบัตรประชาชน';
    }
    if (!RegExp(r'^[0-9]{13}$').hasMatch(value)) {
      return 'เลขบัตรประชาชนไม่ถูกต้อง';
    }
    return null;
  }

  // Validate tax ID
  static String? validateTaxId(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกเลขประจำตัวผู้เสียภาษี';
    }
    if (!RegExp(r'^[0-9]{13}$').hasMatch(value)) {
      return 'เลขประจำตัวผู้เสียภาษีไม่ถูกต้อง';
    }
    return null;
  }
}
