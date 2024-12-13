// lib/core/storage/secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_constants.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;

  SecureStorage._internal();

  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: StorageConstants.accessToken, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: StorageConstants.accessToken);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: StorageConstants.accessToken);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
