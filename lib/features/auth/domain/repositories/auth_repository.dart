// lib/features/auth/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<AppException, User>> login({
    required String username,
    required String password,
  });

  Future<Either<AppException, void>> logout();

  Future<Either<AppException, User>> getCurrentUser();

  Future<Either<AppException, bool>> checkAuth();
}
