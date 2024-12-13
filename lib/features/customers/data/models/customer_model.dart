// lib/features/customers/data/models/customer_model.dart
import '../../domain/entities/customer.dart';
import '../../domain/enums/customer_enums.dart';
import '../../domain/entities/payment_term.dart';
import 'address_model.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required String id,
    required String code,
    required String name,
    String? taxId,
    required String email,
    required String phone,
    required CustomerType type,
    required PaymentTerm paymentTerm,
    CustomerStatus status = CustomerStatus.active,
    required List<AddressModel> addresses,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
          id: id,
          code: code,
          name: name,
          taxId: taxId,
          email: email,
          phone: phone,
          type: type,
          paymentTerm: paymentTerm,
          status: status,
          addresses: addresses,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      taxId: json['taxId'],
      email: json['email'],
      phone: json['phone'],
      type: CustomerType.values.firstWhere(
        (type) => type.code == json['type'],
        orElse: () => CustomerType.cod,
      ),
      paymentTerm: _parsePaymentTerm(json['paymentTerm']),
      status: CustomerStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => CustomerStatus.active,
      ),
      addresses: (json['addresses'] as List)
          .map((address) => AddressModel.fromJson(address))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'taxId': taxId,
      'email': email,
      'phone': phone,
      'type': type.code,
      'paymentTerm': paymentTerm.code,
      'status': status.name,
      'addresses': addresses
          .map((address) => (address as AddressModel).toJson())
          .toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static PaymentTerm _parsePaymentTerm(String code) {
    if (code == 'COD') {
      return PaymentTerm.cod();
    } else {
      final days = int.parse(code.substring(1));
      return PaymentTerm.credit(days);
    }
  }
}
