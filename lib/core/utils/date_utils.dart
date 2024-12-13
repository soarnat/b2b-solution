// lib/core/utils/date_utils.dart
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AppDateUtils {
  static final _thaiDateFormat = DateFormat('d MMMM yyyy', 'th');
  static final _thaiDateTimeFormat = DateFormat('d MMMM yyyy HH:mm', 'th');
  static final _shortDateFormat = DateFormat('dd/MM/yyyy');

  // แปลงวันที่เป็นภาษาไทย
  static String toThaiDate(DateTime date) {
    return _thaiDateFormat.format(date);
  }

  // แปลงวันที่และเวลาเป็นภาษาไทย
  static String toThaiDateTime(DateTime date) {
    return _thaiDateTimeFormat.format(date);
  }

  // แปลงวันที่เป็นรูปแบบสั้น
  static String toShortDate(DateTime date) {
    return _shortDateFormat.format(date);
  }

  // คำนวณจำนวนวันที่เหลือ
  static int daysBetween(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }

  // แปลง string เป็น DateTime
  static DateTime? tryParse(String? dateStr) {
    if (dateStr == null) return null;
    return DateTime.tryParse(dateStr);
  }
}
