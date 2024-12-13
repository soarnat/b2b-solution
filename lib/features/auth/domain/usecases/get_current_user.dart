// lib/features/auth/domain/usecases/get_current_user.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository _repository;

  GetCurrentUser(this._repository);

  Future<Either<AppException, User>> call() {
    return _repository.getCurrentUser();
  }
}
