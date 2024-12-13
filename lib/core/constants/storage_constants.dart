// lib/core/constants/storage_constants.dart
class StorageConstants {
  // Secure Storage Keys
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';

  // Shared Preferences Keys
  static const String isFirstTime = 'is_first_time';
  static const String language = 'language';
  static const String theme = 'theme';
  static const String lastSync = 'last_sync';

  // Hive Box Names
  static const String userBox = 'user_box';
  static const String settingsBox = 'settings_box';
  static const String cacheBox = 'cache_box';

  // Cache Keys
  static const String dashboardCache = 'dashboard_cache';
  static const String productsCache = 'products_cache';
  static const String ordersCache = 'orders_cache';

  // Cache Duration (in minutes)
  static const int cacheDuration = 15;
}
