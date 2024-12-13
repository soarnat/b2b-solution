// lib/features/auth/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/exceptions/exception_handler.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/auth_api.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl({
    required AuthApi authApi,
    required SecureStorage secureStorage,
  })  : _authApi = authApi,
        _secureStorage = secureStorage;

  @override
  Future<Either<AppException, User>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _authApi.login(username, password);

      // บันทึก token
      if (response['token'] != null) {
        await _secureStorage.saveToken(response['token']);
      }

      if (response['user'] != null) {
        final user = UserModel.fromJson(response['user']);
        return Right(user);
      }

      return Left(ServerException(
        message: response['message'] ?? 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ',
      ));
    } catch (e) {
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, void>> logout() async {
    try {
      await _authApi.logout();
      await _secureStorage.deleteToken();
      return const Right(null);
    } catch (e) {
      // ถึงแม้จะมี error แต่เราก็ยังต้องลบ token ออก
      await _secureStorage.deleteToken();
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, User>> getCurrentUser() async {
    try {
      final token = await _secureStorage.getToken();
      if (token == null) {
        return Left(AuthException(
          message: 'ไม่พบข้อมูลการเข้าสู่ระบบ',
        ));
      }

      final user = await _authApi.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, bool>> checkAuth() async {
    try {
      final token = await _secureStorage.getToken();
      if (token == null) {
        return const Right(false);
      }

      final isAuth = await _authApi.checkAuth();
      if (!isAuth) {
        await _secureStorage.deleteToken();
      }
      return Right(isAuth);
    } catch (e) {
      await _secureStorage.deleteToken();
      return Left(ExceptionHandler.handle(e));
    }
  }
}
