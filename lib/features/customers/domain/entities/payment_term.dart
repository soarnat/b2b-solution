// 3. สร้าง payment term (lib/features/customers/domain/entities/payment_term.dart)
import 'package:equatable/equatable.dart';

class PaymentTerm extends Equatable {
  final String code; // N30, COD
  final String display; // เครดิต 30 วัน, เงินสด
  final int days; // จำนวนวัน (0 สำหรับ COD)
  final bool isCredit; // true สำหรับเครดิต

  const PaymentTerm({
    required this.code,
    required this.display,
    required this.days,
    required this.isCredit,
  });

  factory PaymentTerm.cod() {
    return const PaymentTerm(
      code: 'COD',
      display: 'เงินสด',
      days: 0,
      isCredit: false,
    );
  }

  factory PaymentTerm.credit(int days) {
    return PaymentTerm(
      code: 'N$days',
      display: 'เครดิต $days วัน',
      days: days,
      isCredit: true,
    );
  }

  DateTime calculateDueDate(DateTime date) {
    return date.add(Duration(days: days));
  }

  @override
  List<Object?> get props => [code, display, days, isCredit];
}
