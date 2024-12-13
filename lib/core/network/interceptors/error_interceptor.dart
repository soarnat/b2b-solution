// lib/core/network/interceptors/error_interceptor.dart
import 'package:dio/dio.dart';
import '../../exceptions/app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(
          message: 'การเชื่อมต่อขัดข้อง กรุณาลองใหม่อีกครั้ง',
          statusCode: 408,
        );
      case DioExceptionType.badResponse:
        if (err.response?.statusCode == 401) {
          // Handle token expiration
          throw AuthException(
            message: 'Token หมดอายุ กรุณาเข้าสู่ระบบใหม่',
            statusCode: 401,
          );
        }
        handler.next(err);
        break;
      default:
        handler.next(err);
        break;
    }
  }
}
