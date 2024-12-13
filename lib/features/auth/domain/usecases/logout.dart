// lib/features/auth/domain/usecases/logout.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../repositories/auth_repository.dart';

class Logout {
  final AuthRepository _repository;

  Logout(this._repository);

  Future<Either<AppException, void>> call() {
    return _repository.logout();
  }
}
