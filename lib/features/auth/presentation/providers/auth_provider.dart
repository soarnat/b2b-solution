// lib/features/auth/presentation/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/check_auth.dart';

class AuthProvider extends ChangeNotifier {
  final Login _login;
  final Logout _logout;
  final GetCurrentUser _getCurrentUser;
  final CheckAuth _checkAuth;

  AuthProvider({
    required Login login,
    required Logout logout,
    required GetCurrentUser getCurrentUser,
    required CheckAuth checkAuth,
  })  : _login = login,
        _logout = logout,
        _getCurrentUser = getCurrentUser,
        _checkAuth = checkAuth;

  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _setLoading(true);
    _setError(null);

    final result = await _login(
      username: username,
      password: password,
    );

    return result.fold(
      (failure) {
        _setError(failure.message);
        _setLoading(false);
        return false;
      },
      (user) {
        _user = user;
        _setLoading(false);
        return true;
      },
    );
  }

  Future<void> logout() async {
    _setLoading(true);
    _setError(null);

    final result = await _logout();

    result.fold(
      (failure) => _setError(failure.message),
      (_) => _user = null,
    );

    _setLoading(false);
  }

  Future<void> checkAuthStatus() async {
    _setLoading(true);
    _setError(null);

    final isAuth = await _checkAuth();

    await isAuth.fold(
      (failure) async {
        _setError(failure.message);
        _user = null;
      },
      (isAuthenticated) async {
        if (isAuthenticated) {
          final userResult = await _getCurrentUser();
          userResult.fold(
            (failure) {
              _setError(failure.message);
              _user = null;
            },
            (user) => _user = user,
          );
        } else {
          _user = null;
        }
      },
    );

    _setLoading(false);
  }
}
