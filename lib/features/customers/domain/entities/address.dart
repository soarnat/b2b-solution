// lib/features/customers/domain/entities/address.dart
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String address;
  final String subDistrict;
  final String district;
  final String province;
  final String postalCode;
  final bool isDefault;

  const Address({
    required this.address,
    required this.subDistrict,
    required this.district,
    required this.province,
    required this.postalCode,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
        address,
        subDistrict,
        district,
        province,
        postalCode,
        isDefault,
      ];

  // Helper method สำหรับ format address
  String get fullAddress {
    return [
      address,
      subDistrict,
      district,
      province,
      postalCode,
    ].where((part) => part.isNotEmpty).join(' ');
  }
}
