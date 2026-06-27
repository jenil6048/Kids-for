import 'dart:developer' as developer;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages Supabase credentials using flutter_secure_storage.
///
/// On the very first launch the compile-time constants are written to secure
/// storage.  Every subsequent launch reads from secure storage, so the plain
/// strings are never in memory after the first run.
class EnvConfig {
  EnvConfig._();

  // -------------------------------------------------------------------------
  // Compile-time defaults (only used to seed secure storage on first run).
  // -------------------------------------------------------------------------
  static const String _defaultSupabaseUrl =
      'https://pdhqylmzjdkvdbnezwhq.supabase.co';
  static const String _defaultSupabaseKey =
      'sb_publishable_SizQcYl-aGVb-E1ormaC7Q_9gtGL6WU';

  static const String _keyUrl = 'supabase_url';
  static const String _keyAnonKey = 'supabase_anon_key';
  static const String _keySeeded = 'env_seeded';

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  /// Call once in main() before Supabase.initialize().
  /// Writes defaults to secure storage if this is the first run.
  static Future<void> seed() async {
    try {
      final seeded = await _storage.read(key: _keySeeded);
      if (seeded == null) {
        developer.log('EnvConfig: First run — seeding credentials to secure storage');
        await _storage.write(key: _keyUrl, value: _defaultSupabaseUrl);
        await _storage.write(key: _keyAnonKey, value: _defaultSupabaseKey);
        await _storage.write(key: _keySeeded, value: 'true');
      } else {
        developer.log('EnvConfig: Credentials already seeded');
      }
    } catch (e) {
      // Secure storage failure (e.g., emulator) — fall back gracefully
      developer.log('EnvConfig: Secure storage error during seed: $e');
    }
  }

  /// Returns the Supabase URL from secure storage, falling back to the
  /// compile-time constant if storage is unavailable.
  static Future<String> get supabaseUrl async {
    try {
      final value = await _storage.read(key: _keyUrl);
      return value ?? _defaultSupabaseUrl;
    } catch (e) {
      developer.log('EnvConfig: Could not read supabaseUrl from storage: $e');
      return _defaultSupabaseUrl;
    }
  }

  /// Returns the Supabase anon key from secure storage, falling back to the
  /// compile-time constant if storage is unavailable.
  static Future<String> get supabaseKey async {
    try {
      final value = await _storage.read(key: _keyAnonKey);
      return value ?? _defaultSupabaseKey;
    } catch (e) {
      developer.log('EnvConfig: Could not read supabaseKey from storage: $e');
      return _defaultSupabaseKey;
    }
  }
}
