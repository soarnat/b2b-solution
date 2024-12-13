// lib/features/dashboard/domain/repositories/dashboard_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../entities/dashboard_stats.dart';
import '../entities/payment_due.dart';

abstract class DashboardRepository {
  /// ดึงข้อมูลแดชบอร์ดทั้งหมด
  Future<Either<AppException, DashboardStats>> getDashboardStats();

  /// ดึงรายการที่ใกล้ครบกำหนดชำระ
  Future<Either<AppException, List<PaymentDue>>> getPaymentDues({
    required int limit,
  });
}
