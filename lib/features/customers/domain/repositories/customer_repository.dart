// lib/features/customers/domain/repositories/customer_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/customer.dart';
import '../enums/customer_enums.dart';

abstract class CustomerRepository {
  /// ดึงข้อมูลลูกค้าทั้งหมด
  Future<Either<AppException, List<Customer>>> getCustomers();

  /// ดึงข้อมูลลูกค้าตาม id
  Future<Either<AppException, Customer>> getCustomerById(String id);

  /// ดึงข้อมูลลูกค้าตามรหัสลูกค้า
  Future<Either<AppException, Customer>> getCustomerByCode(String code);

  /// ค้นหาลูกค้า
  Future<Either<AppException, List<Customer>>> searchCustomers(String query);

  /// ดึงข้อมูลลูกค้าตามประเภท (COD/Credit)
  Future<Either<AppException, List<Customer>>> getCustomersByType(
    CustomerType type,
  );
}
