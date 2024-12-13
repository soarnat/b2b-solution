// lib/features/auth/data/datasources/auth_api.dart
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

class AuthApi {
  final ApiClient _client;

  AuthApi(this._client);

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.login,
      data: {
        'username': username,
        'password': password,
      },
    );
    return response;
  }

  Future<void> logout() async {
    await _client.post(ApiConstants.logout);
  }

  Future<UserModel> getCurrentUser() async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.currentUser,
    );
    return UserModel.fromJson(response);
  }

  Future<bool> checkAuth() async {
    try {
      await _client.get(ApiConstants.checkAuth);
      return true;
    } catch (e) {
      return false;
    }
  }
}
