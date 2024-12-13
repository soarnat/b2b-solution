// lib/features/auth/data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String username,
    required String email,
    String? fullName,
    String? phoneNumber,
    required List<String> roles,
    required bool isActive,
  }) : super(
          id: id,
          username: username,
          email: email,
          fullName: fullName,
          phoneNumber: phoneNumber,
          roles: roles,
          isActive: isActive,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      roles: List<String>.from(json['roles'] ?? []),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'roles': roles,
      'isActive': isActive,
    };
  }

  // สร้าง UserModel จาก Entity
  factory UserModel.fromEntity(User entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      fullName: entity.fullName,
      phoneNumber: entity.phoneNumber,
      roles: entity.roles,
      isActive: entity.isActive,
    );
  }
}
