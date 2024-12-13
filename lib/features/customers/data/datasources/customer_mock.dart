// lib/features/customers/data/datasources/customer_mock.dart
import '../models/customer_model.dart';
import '../models/address_model.dart';
import '../../domain/enums/customer_enums.dart';
import '../../domain/entities/payment_term.dart';

class CustomerMockData {
  static final List<Map<String, dynamic>> mockCustomers = [
    {
      'id': '1',
      'code': 'CUST001',
      'name': 'บริษัท เอบีซี จำกัด',
      'taxId': '1234567890123',
      'email': 'contact@abc.com',
      'phone': '02-123-4567',
      'type': 'Credit',
      'paymentTerm': 'N30',
      'status': 'active',
      'addresses': [
        {
          'address': '123/45 ถนนพระราม 9',
          'subDistrict': 'ห้วยขวาง',
          'district': 'ห้วยขวาง',
          'province': 'กรุงเทพมหานคร',
          'postalCode': '10310',
          'isDefault': true,
        }
      ],
      'createdAt': '2024-01-01T00:00:00Z',
    },
    {
      'id': '2',
      'code': 'CUST002',
      'name': 'บริษัท เอ็กซ์วาย จำกัด',
      'taxId': '9876543210123',
      'email': 'contact@xy.com',
      'phone': '02-987-6543',
      'type': 'COD',
      'paymentTerm': 'COD',
      'status': 'active',
      'addresses': [
        {
          'address': '456/78 ถนนสุขุมวิท',
          'subDistrict': 'คลองเตย',
          'district': 'คลองเตย',
          'province': 'กรุงเทพมหานคร',
          'postalCode': '10110',
          'isDefault': true,
        }
      ],
      'createdAt': '2024-01-02T00:00:00Z',
    },
  ];

  // แปลง mock data เป็น CustomerModel
  static List<CustomerModel> getMockCustomers() {
    return mockCustomers.map((json) => CustomerModel.fromJson(json)).toList();
  }

  // หา customer ตาม id
  static CustomerModel? findCustomerById(String id) {
    try {
      final json = mockCustomers.firstWhere((c) => c['id'] == id);
      return CustomerModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  // หา customer ตาม code
  static CustomerModel? findCustomerByCode(String code) {
    try {
      final json = mockCustomers.firstWhere((c) => c['code'] == code);
      return CustomerModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }
}
