// lib/features/auth/data/datasources/auth_api.dart
import '../../../../core/exceptions/app_exception.dart';
import '../models/user_model.dart';

class AuthApi {
  const AuthApi();

  Future<Map<String, dynamic>> login(String username, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // ไม่ตรวจสอบ credentials ให้ผ่านเลย
    return {
      'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      'user': {
        'id': '1',
        'username': username, // ใช้ username ที่ส่งมา
        'email': '$username@example.com',
        'fullName': 'Test User',
        'phoneNumber': '02-123-4567',
        'roles': ['USER'],
        'isActive': true,
        'customerCode': 'CUST001',
        'customerType': 'ลูกค้าทั่วไป',
        'creditTerm': 'N30',
      },
    };
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<UserModel> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return UserModel.fromJson({
      'id': '1',
      'username': 'testuser',
      'email': 'testuser@example.com',
      'fullName': 'Test User',
      'phoneNumber': '02-123-4567',
      'roles': ['USER'],
      'isActive': true,
      'customerCode': 'CUST001',
      'customerType': 'ลูกค้าทั่วไป',
      'creditTerm': 'N30',
    });
  }

  Future<bool> checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true; // ให้ผ่านเสมอ
  }
}
