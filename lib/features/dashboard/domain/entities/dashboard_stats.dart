// lib/features/dashboard/domain/entities/dashboard_stats.dart
import 'package:equatable/equatable.dart';
import 'payment_due.dart';
import 'quick_action.dart';

class DashboardStats extends Equatable {
  final String customerCode;
  final String customerName;
  final String customerType;
  final String creditTerm;
  final String phoneNumber;
  final String email;
  final String address;
  final List<PaymentDue> paymentDues;
  final List<QuickAction> quickActions;
  final int notificationCount;

  const DashboardStats({
    required this.customerCode,
    required this.customerName,
    required this.customerType,
    required this.creditTerm,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.paymentDues,
    required this.quickActions,
    this.notificationCount = 0,
  });

  @override
  List<Object?> get props => [
        customerCode,
        customerName,
        customerType,
        creditTerm,
        phoneNumber,
        email,
        address,
        paymentDues,
        quickActions,
        notificationCount,
      ];
}
