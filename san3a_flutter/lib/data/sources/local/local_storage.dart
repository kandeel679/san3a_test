import 'package:shared_preferences/shared_preferences.dart';

/// Mirrors data/source/local/userPreferences (DataStore in Kotlin)
class LocalStorage {
  static const _phoneKey = 'user_phone';
  static const _onboardingKey = 'onboarding_completed';
  static const _darkModeKey = 'dark_mode';
  static const _languageKey = 'language';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> savePhone(String phone) async {
    final prefs = await _prefs;
    await prefs.setString(_phoneKey, phone);
  }

  Future<String?> getPhone() async {
    final prefs = await _prefs;
    return prefs.getString(_phoneKey);
  }

  Future<void> setOnboardingCompleted(bool completed) async {
    final prefs = await _prefs;
    await prefs.setBool(_onboardingKey, completed);
  }

  Future<bool> isOnboardingCompleted() async {
    final prefs = await _prefs;
    return prefs.getBool(_onboardingKey) ?? false;
  }

  Future<void> setDarkMode(bool dark) async {
    final prefs = await _prefs;
    await prefs.setBool(_darkModeKey, dark);
  }

  Stream<bool> isDarkMode() async* {
    final prefs = await _prefs;
    yield prefs.getBool(_darkModeKey) ?? false;
  }

  Future<void> setLanguage(String lang) async {
    final prefs = await _prefs;
    await prefs.setString(_languageKey, lang);
  }

  Stream<String> getLanguage() async* {
    final prefs = await _prefs;
    yield prefs.getString(_languageKey) ?? 'en';
  }

  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
