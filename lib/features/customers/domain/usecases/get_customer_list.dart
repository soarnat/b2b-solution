// lib/features/customers/domain/usecases/get_customer_list.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';
import '../enums/customer_enums.dart';

class GetCustomerList {
  final CustomerRepository repository;

  GetCustomerList(this.repository);

  Future<Either<AppException, List<Customer>>> call() {
    return repository.getCustomers();
  }

  Future<Either<AppException, List<Customer>>> search(String query) {
    return repository.searchCustomers(query);
  }

  Future<Either<AppException, List<Customer>>> byType(CustomerType type) {
    return repository.getCustomersByType(type);
  }
}
