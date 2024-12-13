// lib/features/auth/data/datasources/auth_mock.dart
class AuthMockData {
  static const mockUsers = [
    {
      'id': '1',
      'username': 'user',
      'password': 'password',
      'email': 'user@example.com',
      'fullName': 'Default User',
      'phoneNumber': '02-123-4567',
      'roles': ['USER'],
      'isActive': true,
      'customerCode': 'CUST001',
      'customerType': 'ลูกค้าทั่วไป',
      'creditTerm': 'N30',
    },
    {
      'id': '2',
      'username': 'admin',
      'password': 'admin',
      'email': 'admin@example.com',
      'fullName': 'Admin User',
      'phoneNumber': '02-123-4568',
      'roles': ['ADMIN'],
      'isActive': true,
      'customerCode': 'CUST002',
      'customerType': 'ลูกค้า VIP',
      'creditTerm': 'N45',
    },
  ];
}
