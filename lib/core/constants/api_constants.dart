// lib/core/constants/api_constants.dart
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/v1';
  static const String baseApiUrl = '$baseUrl$apiVersion';

// Auth Endpoints
  static const String login = '$baseApiUrl/auth/login';
  static const String logout = '$baseApiUrl/auth/logout';
  static const String refreshToken = '$baseApiUrl/auth/refresh';
  static const String currentUser = '$baseApiUrl/auth/me';
  static const String checkAuth = '$baseApiUrl/auth/check';

  // Dashboard Endpoints
  static const String dashboardStats = '$baseApiUrl/dashboard/stats';
  static const String salesStats = '$baseApiUrl/dashboard/sales';
  static const String recentOrders = '$baseApiUrl/dashboard/orders/recent';

  // Order Endpoints
  static const String orders = '$baseApiUrl/orders';
  static const String orderDetails = '$baseApiUrl/orders/{id}';
  static const String createOrder = '$baseApiUrl/orders';
  static const String updateOrder = '$baseApiUrl/orders/{id}';

  // Product Endpoints
  static const String products = '$baseApiUrl/products';
  static const String productDetails = '$baseApiUrl/products/{id}';
  static const String productCategories = '$baseApiUrl/products/categories';

  // User Profile Endpoints
  static const String userProfile = '$baseApiUrl/profile';
  static const String updateProfile = '$baseApiUrl/profile/update';
  static const String changePassword = '$baseApiUrl/profile/password';

  // Timeout configs
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Headers
  static const String authHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';

  // Response Keys
  static const String dataKey = 'data';
  static const String messageKey = 'message';
  static const String errorKey = 'error';
  static const String tokenKey = 'token';
}
