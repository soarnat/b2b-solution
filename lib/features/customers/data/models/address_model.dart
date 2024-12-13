// lib/features/customers/data/models/address_model.dart
import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required String address,
    required String subDistrict,
    required String district,
    required String province,
    required String postalCode,
    bool isDefault = false,
  }) : super(
          address: address,
          subDistrict: subDistrict,
          district: district,
          province: province,
          postalCode: postalCode,
          isDefault: isDefault,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      subDistrict: json['subDistrict'],
      district: json['district'],
      province: json['province'],
      postalCode: json['postalCode'],
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'subDistrict': subDistrict,
      'district': district,
      'province': province,
      'postalCode': postalCode,
      'isDefault': isDefault,
    };
  }
}
