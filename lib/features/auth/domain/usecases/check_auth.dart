// lib/features/auth/domain/usecases/check_auth.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../repositories/auth_repository.dart';

class CheckAuth {
  final AuthRepository _repository;

  CheckAuth(this._repository);

  Future<Either<AppException, bool>> call() {
    return _repository.checkAuth();
  }
}
