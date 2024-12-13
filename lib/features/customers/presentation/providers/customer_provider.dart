// lib/features/customers/presentation/providers/customer_provider.dart
import 'package:flutter/foundation.dart';
import '../../domain/entities/customer.dart';
import '../../domain/enums/customer_enums.dart';
import '../../domain/usecases/get_customer.dart';
import '../../domain/usecases/get_customer_list.dart';

class CustomerProvider extends ChangeNotifier {
  final GetCustomer _getCustomer;
  final GetCustomerList _getCustomerList;

  CustomerProvider({
    required GetCustomer getCustomer,
    required GetCustomerList getCustomerList,
  })  : _getCustomer = getCustomer,
        _getCustomerList = getCustomerList;

  List<Customer> _customers = [];
  Customer? _selectedCustomer;
  bool _isLoading = false;
  String? _error;
  CustomerType _selectedType = CustomerType.cod;

  // Getters
  List<Customer> get customers => _customers;
  Customer? get selectedCustomer => _selectedCustomer;
  bool get isLoading => _isLoading;
  String? get error => _error;
  CustomerType get selectedType => _selectedType;

  // Methods
  Future<void> loadCustomers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _getCustomerList();

    result.fold(
      (failure) {
        _error = failure.message;
        _customers = [];
      },
      (customers) {
        _customers = customers;
        _error = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> selectCustomer(String id) async {
    _isLoading = true;
    notifyListeners();

    final result = await _getCustomer.byId(id);

    result.fold(
      (failure) {
        _error = failure.message;
        _selectedCustomer = null;
      },
      (customer) {
        _selectedCustomer = customer;
        _error = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchCustomers(String query) async {
    if (query.isEmpty) {
      await loadCustomers();
      return;
    }

    _isLoading = true;
    notifyListeners();

    final result = await _getCustomerList.search(query);

    result.fold(
      (failure) {
        _error = failure.message;
        _customers = [];
      },
      (customers) {
        _customers = customers;
        _error = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> filterByType(CustomerType type) async {
    _selectedType = type;
    _isLoading = true;
    notifyListeners();

    final result = await _getCustomerList.byType(type);

    result.fold(
      (failure) {
        _error = failure.message;
        _customers = [];
      },
      (customers) {
        _customers = customers;
        _error = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void clearSelection() {
    _selectedCustomer = null;
    notifyListeners();
  }
}
