// lib/core/network/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import '../../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage().getToken();

    if (token != null) {
      options.headers[ApiConstants.authHeader] =
          '${ApiConstants.bearerPrefix} $token';
    }

    handler.next(options);
  }
}
