import 'package:flutter/material.dart';
import '../hive/hive_service.dart';

class SettingsRepository {
  SettingsRepository._internal();
  static final SettingsRepository instance = SettingsRepository._internal();

  static const String _keySoundEnabled = 'sound_enabled';
  static const String _keyDarkModeEnabled = 'dark_mode_enabled';
  static const String _keyLanguageCode = 'language_code';
  static const String _keyUserPreferences = 'user_preferences';

  late final ValueNotifier<bool> soundNotifier;
  late final ValueNotifier<bool> darkModeNotifier;
  late final ValueNotifier<String> languageNotifier;

  /// Initialize default values and notifiers from the Hive box.
  void init() {
    final box = HiveService.instance.settingsBox;

    final sound = box.get(_keySoundEnabled, defaultValue: true) as bool;
    final darkMode = box.get(_keyDarkModeEnabled, defaultValue: false) as bool;
    final lang = box.get(_keyLanguageCode, defaultValue: 'en') as String;

    soundNotifier = ValueNotifier<bool>(sound);
    darkModeNotifier = ValueNotifier<bool>(darkMode);
    languageNotifier = ValueNotifier<String>(lang);
  }

  // --- Sound Preference ---
  bool get isSoundEnabled => soundNotifier.value;

  Future<void> setSoundEnabled(bool enabled) async {
    soundNotifier.value = enabled;
    await HiveService.instance.settingsBox.put(_keySoundEnabled, enabled);
  }

  // --- Dark Mode Preference ---
  bool get isDarkModeEnabled => darkModeNotifier.value;

  Future<void> setDarkModeEnabled(bool enabled) async {
    darkModeNotifier.value = enabled;
    await HiveService.instance.settingsBox.put(_keyDarkModeEnabled, enabled);
  }

  // --- Language Preference ---
  String get languageCode => languageNotifier.value;

  Future<void> setLanguageCode(String code) async {
    languageNotifier.value = code;
    await HiveService.instance.settingsBox.put(_keyLanguageCode, code);
  }

  // --- General User Preferences ---
  Map<String, dynamic> getUserPreferences() {
    final Map<dynamic, dynamic> prefs = HiveService.instance.settingsBox.get(_keyUserPreferences, defaultValue: <String, dynamic>{}) as Map;
    return Map<String, dynamic>.from(prefs);
  }

  Future<void> setUserPreference(String key, dynamic value) async {
    final prefs = getUserPreferences();
    prefs[key] = value;
    await HiveService.instance.settingsBox.put(_keyUserPreferences, prefs);
  }

  Future<void> clearUserPreferences() async {
    await HiveService.instance.settingsBox.delete(_keyUserPreferences);
  }
}
