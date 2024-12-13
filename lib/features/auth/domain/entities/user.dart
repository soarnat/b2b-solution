// lib/features/auth/domain/entities/user.dart
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? phoneNumber;
  final List<String> roles;
  final bool isActive;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.phoneNumber,
    required this.roles,
    required this.isActive,
  });

  bool get isAdmin => roles.contains('ADMIN');
  bool get isUser => roles.contains('USER');

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        fullName,
        phoneNumber,
        roles,
        isActive,
      ];
}
