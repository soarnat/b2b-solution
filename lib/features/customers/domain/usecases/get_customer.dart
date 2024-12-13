// lib/features/customers/domain/usecases/get_customer.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class GetCustomer {
  final CustomerRepository repository;

  GetCustomer(this.repository);

  Future<Either<AppException, Customer>> byId(String id) {
    return repository.getCustomerById(id);
  }

  Future<Either<AppException, Customer>> byCode(String code) {
    return repository.getCustomerByCode(code);
  }
}
