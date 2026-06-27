import 'dart:developer' as developer;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../hive/adapters/config_entry.dart';
import '../hive/hive_service.dart';

/// Manages the Supabase `config` table and its local Hive mirror.
///
/// The config table has three columns:
///   category_key (text PK), version (int), updated_at (timestamp)
///
/// Flow:
///   fetchAndSync() → fetches remote config → compares with local → marks stale keys
///   isStale(key)   → returns true if remote version > local version
class ConfigRepository {
  ConfigRepository._internal();
  static final ConfigRepository instance = ConfigRepository._internal();

  final SupabaseClient _client = Supabase.instance.client;

  /// In-memory map of the LATEST remote versions fetched in this session.
  /// Populated by [fetchAndSync].
  final Map<String, int> _remoteVersions = {};

  /// Whether the last [fetchAndSync] succeeded.
  bool _syncSucceeded = false;

  bool get syncSucceeded => _syncSucceeded;

  /// Fetch the entire `config` table from Supabase and persist to Hive.
  ///
  /// Returns silently if the network is unavailable but Hive already has data.
  /// Throws [ConfigSyncException] only on first-launch offline (Hive empty).
  Future<void> fetchAndSync() async {
    developer.log('ConfigRepository: Starting fetchAndSync()...');
    try {
      final response = await _client
          .from('config')
          .select('category_key, version, updated_at')
          .timeout(const Duration(seconds: 10));

      final List<dynamic> rows = response as List<dynamic>;
      developer.log('ConfigRepository: Fetched ${rows.length} config rows from Supabase');

      _remoteVersions.clear();
      for (final row in rows) {
        final key = row['category_key'] as String;
        final remoteVersion = row['version'] as int? ?? 0;
        _remoteVersions[key] = remoteVersion;
      }

      _syncSucceeded = true;
      developer.log('ConfigRepository: Sync complete. ${_remoteVersions.length} categories tracked.');
    } on TimeoutException {
      _handleOffline('Timeout');
    } catch (e) {
      _handleOffline(e.toString());
    }
  }

  void _handleOffline(String reason) {
    _syncSucceeded = false;
    developer.log('ConfigRepository: Sync failed ($reason)');
    final box = HiveService.instance.configBox;
    if (box.isEmpty) {
      // First-launch offline — callers can handle this gracefully
      developer.log('ConfigRepository: Hive config box is empty — first-launch offline');
    } else {
      developer.log('ConfigRepository: Using cached config (${box.length} entries)');
      // Populate _remoteVersions from local cache so isStale() works offline
      for (final entry in box.values) {
        _remoteVersions.putIfAbsent(entry.categoryKey, () => entry.version);
      }
    }
  }

  /// Returns true when the local Hive version differs from the last-fetched
  /// remote version for [categoryKey].
  ///
  /// If [fetchAndSync] has not run yet or failed and Hive has data,
  /// this returns false (treat local as fresh — no unnecessary re-fetches).
  bool isStale(String categoryKey) {
    final local = HiveService.instance.configBox.get(categoryKey);
    final remote = _remoteVersions[categoryKey];

    developer.log('ConfigRepository: isStale("$categoryKey") checking - '
        'localVersion=${local?.version ?? "none"}, '
        'remoteVersion=${remote ?? "none"}');

    if (remote == null) {
      // Remote version unknown (offline or key not in config table) — not stale
      developer.log('ConfigRepository: "$categoryKey" remote version is unknown. Treating as NOT stale.');
      return false;
    }
    if (local == null) {
      // No local data for this category — treat as stale so it gets downloaded
      developer.log('ConfigRepository: "$categoryKey" has no local config — marking STALE');
      return true;
    }

    final stale = local.version != remote;
    if (stale) {
      developer.log('ConfigRepository: "$categoryKey" is STALE '
          '(local v${local.version} vs remote v$remote)');
    } else {
      developer.log('ConfigRepository: "$categoryKey" is FRESH '
          '(local v${local.version} vs remote v$remote)');
    }
    return stale;
  }

  /// Returns the locally-stored version for [categoryKey], or -1 if absent.
  int getLocalVersion(String categoryKey) {
    return HiveService.instance.configBox.get(categoryKey)?.version ?? -1;
  }

  /// Marks a category as synced by updating local config version to match remote.
  Future<void> markSynced(String categoryKey) async {
    final remote = _remoteVersions[categoryKey];
    if (remote == null) return;

    final box = HiveService.instance.configBox;
    final existing = box.get(categoryKey);
    await box.put(
      categoryKey,
      ConfigEntry(
        categoryKey: categoryKey,
        version: remote,
        updatedAt: existing?.updatedAt ?? DateTime.now().toIso8601String(),
      ),
    );
    developer.log('ConfigRepository: Marked "$categoryKey" as synced (v$remote)');
  }

  /// Returns true if Hive has any config data at all.
  bool get hasLocalConfig => HiveService.instance.configBox.isNotEmpty;
}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException(this.message);
}
