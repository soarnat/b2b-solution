// lib/core/exceptions/app_exception.dart
import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  final String message;
  final String? code;
  final int? statusCode;

  const AppException({
    required this.message,
    this.code,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, code, statusCode];
}

// NetworkException, ServerException, และ AuthException ควรอยู่ในไฟล์เดียวกัน
class NetworkException extends AppException {
  const NetworkException({
    String message = 'ไม่สามารถเชื่อมต่อเครือข่ายได้',
    String? code,
    int? statusCode,
  }) : super(
          message: message,
          code: code,
          statusCode: statusCode,
        );
}

class ServerException extends AppException {
  const ServerException({
    required String message,
    String? code,
    int? statusCode,
  }) : super(
          message: message,
          code: code,
          statusCode: statusCode,
        );
}

class AuthException extends AppException {
  const AuthException({
    String message = 'กรุณาเข้าสู่ระบบใหม่อีกครั้ง',
    String? code,
    int? statusCode = 401,
  }) : super(
          message: message,
          code: code,
          statusCode: statusCode,
        );
}

// เพิ่ม ValidationException
class ValidationException extends AppException {
  final Map<String, dynamic>? errors;

  const ValidationException({
    required String message,
    this.errors,
    String? code,
    int? statusCode = 422,
  }) : super(
          message: message,
          code: code,
          statusCode: statusCode,
        );

  @override
  List<Object?> get props => [...super.props, errors];
}
