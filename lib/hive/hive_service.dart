import 'dart:developer' as developer;
import 'package:hive_flutter/hive_flutter.dart';
import 'adapters/config_entry.dart';
import 'adapters/hive_category.dart';
import 'adapters/hive_group.dart';
import 'adapters/hive_topic.dart';

/// Central Hive manager — singleton.
/// Call [init] once in main() before anything else.
class HiveService {
  HiveService._internal();
  static final HiveService instance = HiveService._internal();

  static const String _configBoxName = 'config_box';
  static const String _categoriesBoxName = 'categories_box';
  static const String _groupsBoxName = 'groups_box';
  static const String _settingsBoxName = 'settings_box';

  late Box<ConfigEntry> configBox;
  late Box<HiveCategory> categoriesBox;
  late Box<HiveGroup> groupsBox;
  late Box<dynamic> settingsBox;

  final Map<String, Box<HiveTopic>> _topicBoxes = {};

  /// Initialise Hive, register adapters, and open core boxes.
  Future<void> init() async {
    developer.log('HiveService: Starting init()...');
    try {
      developer.log('HiveService: Step 1 - Hive.initFlutter()');
      await Hive.initFlutter();
      developer.log('HiveService: Step 1 complete');

      developer.log('HiveService: Step 2 - Registering adapters');
      // Register adapters (guard against double-registration)
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ConfigEntryAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(HiveCategoryAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(HiveGroupAdapter());
      }
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(HiveTopicAdapter());
      }
      developer.log('HiveService: Step 2 complete');

      developer.log('HiveService: Step 3 - Opening configBox');
      try {
        configBox = await Hive.openBox<ConfigEntry>(_configBoxName);
      } catch (e) {
        developer.log('HiveService: Error opening configBox, attempting recovery: $e');
        await Hive.deleteBoxFromDisk(_configBoxName);
        configBox = await Hive.openBox<ConfigEntry>(_configBoxName);
      }
      developer.log('HiveService: Step 3 complete');

      developer.log('HiveService: Step 4 - Opening categoriesBox');
      try {
        categoriesBox = await Hive.openBox<HiveCategory>(_categoriesBoxName);
      } catch (e) {
        developer.log('HiveService: Error opening categoriesBox, attempting recovery: $e');
        await Hive.deleteBoxFromDisk(_categoriesBoxName);
        categoriesBox = await Hive.openBox<HiveCategory>(_categoriesBoxName);
      }
      developer.log('HiveService: Step 4 complete');

      developer.log('HiveService: Step 5 - Opening groupsBox');
      try {
        groupsBox = await Hive.openBox<HiveGroup>(_groupsBoxName);
      } catch (e) {
        developer.log('HiveService: Error opening groupsBox, attempting recovery: $e');
        await Hive.deleteBoxFromDisk(_groupsBoxName);
        groupsBox = await Hive.openBox<HiveGroup>(_groupsBoxName);
      }
      developer.log('HiveService: Step 5 complete');

      developer.log('HiveService: Step 6 - Opening settingsBox');
      try {
        settingsBox = await Hive.openBox<dynamic>(_settingsBoxName);
      } catch (e) {
        developer.log('HiveService: Error opening settingsBox, attempting recovery: $e');
        await Hive.deleteBoxFromDisk(_settingsBoxName);
        settingsBox = await Hive.openBox<dynamic>(_settingsBoxName);
      }
      developer.log('HiveService: Step 6 complete');

      developer.log('HiveService: Init complete. '
          'Config entries: ${configBox.length}, '
          'Categories: ${categoriesBox.length}, '
          'Groups: ${groupsBox.length}, '
          'Settings: ${settingsBox.length}');
    } catch (globalError) {
      developer.log('HiveService: Critical error during Hive initialization: $globalError');
    }
  }

  /// Lazily open a per-category topic box.
  Future<Box<HiveTopic>> openTopicBox(String categoryKey) async {
    final boxName = '${categoryKey}_topics_box';
    if (_topicBoxes.containsKey(categoryKey) &&
        _topicBoxes[categoryKey]!.isOpen) {
      return _topicBoxes[categoryKey]!;
    }
    developer.log('HiveService: Opening topic box "$boxName"');
    final box = await Hive.openBox<HiveTopic>(boxName);
    _topicBoxes[categoryKey] = box;
    return box;
  }

  /// Returns the topic box if already open, otherwise opens it.
  Future<Box<HiveTopic>> getTopicBox(String categoryKey) =>
      openTopicBox(categoryKey);

  /// Clear and delete all data in a category''s topic box.
  Future<void> clearTopicBox(String categoryKey) async {
    final box = await openTopicBox(categoryKey);
    await box.clear();
    developer.log('HiveService: Cleared topic box for "$categoryKey"');
  }

  /// Clear the categories and groups boxes (forces re-fetch on next load).
  Future<void> clearCategoryCache() async {
    await categoriesBox.clear();
    await groupsBox.clear();
    developer.log('HiveService: Cleared category + group cache');
  }

  /// Close all open boxes gracefully (call on app shutdown if needed).
  Future<void> close() async {
    await Hive.close();
    _topicBoxes.clear();
  }
}
