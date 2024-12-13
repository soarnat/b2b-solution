// lib/core/storage/shared_preferences.dart
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveLanguage(String languageCode) async {
    await _prefs.setString('language', languageCode);
  }
}
