// lib/core/utils/app_number_utils.dart
import 'dart:math' show pow; // เพิ่มบรรทัดนี้กรณี error pow
import 'package:intl/intl.dart';

class AppNumberUtils {
  static final _currencyFormat = NumberFormat.currency(
    locale: 'th',
    symbol: '฿',
    decimalDigits: 2,
  );

  static final _compactCurrencyFormat = NumberFormat.compactCurrency(
    locale: 'th',
    symbol: '฿',
    decimalDigits: 0,
  );

  static final _numberFormat = NumberFormat('#,##0.##', 'th');
  static final _percentFormat = NumberFormat('##0.00', 'th');

  /// แปลงตัวเลขเป็นรูปแบบเงินบาท (฿1,234.56)
  static String toCurrency(num? amount) {
    if (amount == null) return '฿0.00';
    return _currencyFormat.format(amount);
  }

  /// แปลงตัวเลขเป็นรูปแบบเงินบาทแบบย่อ (฿1.2K, ฿1.2M)
  static String toCompactCurrency(num? amount) {
    if (amount == null) return '฿0';
    return _compactCurrencyFormat.format(amount);
  }

  /// แปลงตัวเลขเป็นรูปแบบมีคอมม่า (1,234.56)
  static String toNumber(num? number) {
    if (number == null) return '0';
    return _numberFormat.format(number);
  }

  /// แปลงตัวเลขเป็นเปอร์เซ็นต์ (12.34%)
  static String toPercent(num? number) {
    if (number == null) return '0.00%';
    return '${_percentFormat.format(number)}%';
  }

  /// แปลง string เป็น double
  static double? tryParseDouble(String? value) {
    if (value == null) return null;
    return double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), ''));
  }

  /// แปลง string เป็น int
  static int? tryParseInt(String? value) {
    if (value == null) return null;
    return int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), ''));
  }

  /// ปัดเศษทศนิยม
  static double roundToDecimalPlaces(double number, int decimalPlaces) {
    final factor = pow(10, decimalPlaces);
    return (number * factor).round() / factor;
  }

  /// คำนวณเปอร์เซ็นต์
  static double calculatePercentage(num value, num total) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }

  /// คำนวณส่วนลด
  static double calculateDiscount(num original, num discounted) {
    if (original == 0) return 0;
    return ((original - discounted) / original) * 100;
  }

  /// แปลงตัวเลขเป็นคำอ่านภาษาไทย (ยังไม่สมบูรณ์ ใช้เป็นตัวอย่าง)
  static String toThaiText(num number) {
    final units = [
      '',
      'หนึ่ง',
      'สอง',
      'สาม',
      'สี่',
      'ห้า',
      'หก',
      'เจ็ด',
      'แปด',
      'เก้า'
    ];
    final positions = ['', 'สิบ', 'ร้อย', 'พัน', 'หมื่น', 'แสน', 'ล้าน'];

    if (number == 0) return 'ศูนย์';

    String text = '';
    int numberInt = number.round();

    // ตัวอย่างอย่างง่าย สำหรับตัวเลข 0-9999
    while (numberInt > 0) {
      final digit = numberInt % 10;
      final position = text.length ~/ 3;
      if (digit > 0) {
        text = '${units[digit]}${positions[position]} $text';
      }
      numberInt ~/= 10;
    }

    return text.trim();
  }
}

/// Extension สำหรับใช้งานง่ายขึ้น
extension NumberFormatExtension on num {
  String toCurrency() => AppNumberUtils.toCurrency(this);
  String toCompactCurrency() => AppNumberUtils.toCompactCurrency(this);
  String toNumber() => AppNumberUtils.toNumber(this);
  String toPercent() => AppNumberUtils.toPercent(this);
}
