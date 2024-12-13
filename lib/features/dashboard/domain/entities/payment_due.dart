// lib/features/dashboard/domain/entities/payment_due.dart
import 'package:equatable/equatable.dart';

class PaymentDue extends Equatable {
  final String invoiceNo;
  final DateTime dueDate;
  final double amount;
  final bool isOverdue;

  const PaymentDue({
    required this.invoiceNo,
    required this.dueDate,
    required this.amount,
    required this.isOverdue,
  });

  int get daysRemaining {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    return difference;
  }

  @override
  List<Object> get props => [invoiceNo, dueDate, amount, isOverdue];
}
