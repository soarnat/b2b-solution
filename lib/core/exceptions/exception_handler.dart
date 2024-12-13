// lib/core/exceptions/exception_handler.dart
import 'dart:io';
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import './app_exception.dart';

class ExceptionHandler {
  static AppException handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }

    if (error is AppException) {
      return error;
    }

    // กรณีที่เป็น error ทั่วไป
    if (error is ValidationException) {
      return error;
    }

    return ServerException(
      message: error?.toString() ?? AppConstants.defaultErrorMessage,
      statusCode: 500,
    );
  }

  static AppException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkException(
          message: 'การเชื่อมต่อขัดข้อง กรุณาลองใหม่อีกครั้ง',
          statusCode: 408,
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return const ServerException(
          message: 'คำขอถูกยกเลิก',
          statusCode: 499,
        );

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return const NetworkException(
            message: 'ไม่สามารถเชื่อมต่อเครือข่ายได้',
            statusCode: 503,
          );
        }
        return ServerException(
          message: AppConstants.defaultErrorMessage,
          statusCode: 500,
        );

      default:
        return ServerException(
          message: error.message ?? AppConstants.defaultErrorMessage,
          statusCode: 500,
        );
    }
  }

  static AppException _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    final message = data?['message'] ?? AppConstants.defaultErrorMessage;
    final code = data?['code']?.toString();
    final errors = data?['errors'] as Map<String, dynamic>?;

    switch (statusCode) {
      case 401:
        return AuthException(
          message: message,
          code: code,
        );
      case 403:
        return AuthException(
          message: 'ไม่มีสิทธิ์เข้าถึง',
          code: code,
          statusCode: statusCode,
        );
      case 404:
        return ServerException(
          message: 'ไม่พบข้อมูลที่ร้องขอ',
          code: code,
          statusCode: statusCode,
        );
      case 422:
        return ValidationException(
          message: message,
          errors: errors,
          code: code,
        );
      case 500:
      case 501:
      case 503:
        return ServerException(
          message: 'เกิดข้อผิดพลาดจากเซิร์ฟเวอร์',
          code: code,
          statusCode: statusCode,
        );
      default:
        return ServerException(
          message: message,
          code: code,
          statusCode: statusCode,
        );
    }
  }
}
