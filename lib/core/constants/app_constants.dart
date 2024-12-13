// lib/core/constants/app_constants.dart
class AppConstants {
  // App Info
  static const String appName = 'B2B Solution';
  static const String appVersion = '1.0.0';

  // Default Values
  static const int defaultPageSize = 10;
  static const String defaultDateFormat = 'dd/MM/yyyy';
  static const String defaultDateTimeFormat = 'dd/MM/yyyy HH:mm';

  // Route Names
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String productsRoute = '/products';
  static const String ordersRoute = '/orders';

  // Asset Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderImagePath = 'assets/images/placeholder.png';

  // Error Messages
  static const String defaultErrorMessage =
      'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง';
  static const String networkErrorMessage = 'ไม่สามารถเชื่อมต่อเครือข่ายได้';
  static const String authErrorMessage = 'กรุณาเข้าสู่ระบบใหม่อีกครั้ง';

  // Success Messages
  static const String loginSuccess = 'เข้าสู่ระบบสำเร็จ';
  static const String logoutSuccess = 'ออกจากระบบสำเร็จ';

  // Validation Messages
  static const String requiredField = 'กรุณากรอกข้อมูล';
  static const String invalidEmail = 'อีเมลไม่ถูกต้อง';
  static const String invalidPhone = 'เบอร์โทรศัพท์ไม่ถูกต้อง';
}
