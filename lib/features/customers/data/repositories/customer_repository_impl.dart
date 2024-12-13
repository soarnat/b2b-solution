// lib/features/customers/data/repositories/customer_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../../domain/entities/customer.dart';
import '../../domain/enums/customer_enums.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_mock.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  @override
  Future<Either<AppException, List<Customer>>> getCustomers() async {
    try {
      final customers = CustomerMockData.getMockCustomers();
      return Right(customers);
    } catch (e) {
      return Left(
        ServerException(
          message: 'ไม่สามารถดึงข้อมูลลูกค้าได้',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, Customer>> getCustomerById(String id) async {
    try {
      final customer = CustomerMockData.findCustomerById(id);
      if (customer == null) {
        return Left(
          ServerException(
            message: 'ไม่พบข้อมูลลูกค้า',
          ),
        );
      }
      return Right(customer);
    } catch (e) {
      return Left(
        ServerException(
          message: 'ไม่สามารถดึงข้อมูลลูกค้าได้',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, Customer>> getCustomerByCode(String code) async {
    try {
      final customer = CustomerMockData.findCustomerByCode(code);
      if (customer == null) {
        return Left(
          ServerException(
            message: 'ไม่พบข้อมูลลูกค้า',
          ),
        );
      }
      return Right(customer);
    } catch (e) {
      return Left(
        ServerException(
          message: 'ไม่สามารถดึงข้อมูลลูกค้าได้',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<Customer>>> searchCustomers(
      String query) async {
    try {
      final customers = CustomerMockData.getMockCustomers()
          .where((customer) =>
              customer.name.toLowerCase().contains(query.toLowerCase()) ||
              customer.code.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Right(customers);
    } catch (e) {
      return Left(
        ServerException(
          message: 'ไม่สามารถค้นหาข้อมูลลูกค้าได้',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, List<Customer>>> getCustomersByType(
    CustomerType type,
  ) async {
    try {
      final customers = CustomerMockData.getMockCustomers()
          .where((customer) => customer.type == type)
          .toList();
      return Right(customers);
    } catch (e) {
      return Left(
        ServerException(
          message: 'ไม่สามารถดึงข้อมูลลูกค้าได้',
        ),
      );
    }
  }
}
