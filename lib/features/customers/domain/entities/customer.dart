// 4. สร้าง customer entity (lib/features/customers/domain/entities/customer.dart)
import 'package:equatable/equatable.dart';
import '../enums/customer_enums.dart';
import 'address.dart';
import 'payment_term.dart';

class Customer extends Equatable {
  final String id;
  final String code; // รหัสลูกค้า
  final String name; // ชื่อบริษัท
  final String? taxId; // เลขประจำตัวผู้เสียภาษี
  final String email;
  final String phone;
  final CustomerType type; // ประเภทลูกค้า (COD/Credit)
  final PaymentTerm paymentTerm; // เงื่อนไขการชำระเงิน
  final CustomerStatus status;
  final List<Address> addresses;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Customer({
    required this.id,
    required this.code,
    required this.name,
    this.taxId,
    required this.email,
    required this.phone,
    required this.type,
    required this.paymentTerm,
    this.status = CustomerStatus.active,
    required this.addresses,
    required this.createdAt,
    this.updatedAt,
  });

  // Helpers
  bool get isActive => status == CustomerStatus.active;
  bool get isCOD => type == CustomerType.cod;
  bool get isCredit => type == CustomerType.credit;

  Address? get defaultAddress =>
      addresses.firstWhere((address) => address.isDefault,
          orElse: () => addresses.first);

  @override
  List<Object?> get props => [
        id,
        code,
        name,
        taxId,
        email,
        phone,
        type,
        paymentTerm,
        status,
        addresses,
        createdAt,
        updatedAt,
      ];
}
