import 'dart:convert';
import 'dart:developer' as developer;
import '../hive/adapters/hive_category.dart';
import '../hive/adapters/hive_group.dart';
import '../hive/hive_service.dart';
import '../models/category_model.dart';
import '../models/group_model.dart';
import '../models/localized_text.dart';
import '../repositories/config_repository.dart';
import '../services/supabase_service.dart';

/// Repository for categories and groups.
///
/// Always returns data from Hive unless:
///   - Hive is empty  (first load)
///   - ConfigRepository says the category versions changed
class CategoryRepository {
  CategoryRepository._internal();
  static final CategoryRepository instance = CategoryRepository._internal();

  /// The special config key for the categories list itself.
  static const String _configKey = 'categories';

  List<CategoryModel> _cachedCategories = [];

  /// Fetch all categories (with embedded groups).
  ///
  /// Priority: Memory Cache -> Hive → Supabase (if empty, stale, or forceRefresh is true)
  Future<List<CategoryModel>> getCategories({bool forceRefresh = false}) async {
    developer.log('CategoryRepository: getCategories(forceRefresh=$forceRefresh) called');
    if (!forceRefresh && _cachedCategories.isNotEmpty) {
      developer.log('CategoryRepository: MEMORY CACHE HIT. Returning ${_cachedCategories.length} categories.');
      return _cachedCategories;
    }

    final box = HiveService.instance.categoriesBox;
    final isStale = ConfigRepository.instance.isStale(_configKey);
    final needsRefresh = forceRefresh || box.isEmpty || isStale;

    developer.log('CategoryRepository: Cache Status - '
        'box.isEmpty=${box.isEmpty}, '
        'isStale=$isStale, '
        'forceRefresh=$forceRefresh, '
        'needsRefresh=$needsRefresh');

    if (!needsRefresh) {
      developer.log('CategoryRepository: HIVE CACHE HIT. Serving ${box.length} categories.');
      _cachedCategories = _fromHive();
      return _cachedCategories;
    }

    developer.log('CategoryRepository: Fetching categories from Supabase...');
    try {
      final remote = await SupabaseService.instance.getCategories();
      if (remote.isNotEmpty) {
        await _saveToHive(remote);
        await ConfigRepository.instance.markSynced(_configKey);
        developer.log('CategoryRepository: Saved ${remote.length} categories to Hive');
        _cachedCategories = remote;
      } else if (box.isNotEmpty) {
        developer.log('CategoryRepository: Remote categories empty, using Hive cache');
        _cachedCategories = _fromHive();
      }
      return _cachedCategories;
    } catch (e) {
      developer.log('CategoryRepository: Supabase fetch failed ($e)');
      if (box.isNotEmpty) {
        developer.log('CategoryRepository: Falling back to ${box.length} Hive categories');
        _cachedCategories = _fromHive();
        return _cachedCategories;
      }
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  // Hive helpers
  // ---------------------------------------------------------------------------

  List<CategoryModel> _fromHive() {
    final categories = HiveService.instance.categoriesBox.values
        .map(_hiveToModel)
        .toList();
    categories.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return categories;
  }

  Future<void> _saveToHive(List<CategoryModel> categories) async {
    final catBox = HiveService.instance.categoriesBox;
    final groupBox = HiveService.instance.groupsBox;

    await catBox.clear();
    await groupBox.clear();

    for (final cat in categories) {
      // Save embedded group separately
      if (cat.group != null) {
        await groupBox.put(cat.group!.id, _groupToHive(cat.group!));
      }
      await catBox.put(cat.categoryKey, _modelToHive(cat));
    }
  }

  HiveCategory _modelToHive(CategoryModel m) {
    String? groupJsonStr;
    if (m.group != null) {
      groupJsonStr = jsonEncode(m.group!.toJson());
    }
    return HiveCategory(
      id: m.id,
      categoryKey: m.categoryKey,
      titleJson: jsonEncode(m.title.toJson()),
      color: m.color,
      isPremium: m.isPremium,
      groupId: m.groupId,
      imagePath: m.imagePath,
      lottiePath: m.lottiePath,
      displayOrder: m.displayOrder,
      groupJson: groupJsonStr,
    );
  }

  CategoryModel _hiveToModel(HiveCategory h) {
    final titleMap = Map<String, dynamic>.from(
        jsonDecode(h.titleJson) as Map);
    GroupModel? group;
    if (h.groupJson != null) {
      final groupMap = Map<String, dynamic>.from(
          jsonDecode(h.groupJson!) as Map);
      group = GroupModel.fromJson(groupMap);
    }
    return CategoryModel(
      id: h.id,
      categoryKey: h.categoryKey,
      title: LocalizedText.fromJson(titleMap),
      color: h.color,
      isPremium: h.isPremium,
      groupId: h.groupId,
      imagePath: h.imagePath,
      lottiePath: h.lottiePath,
      displayOrder: h.displayOrder,
      group: group,
    );
  }

  HiveGroup _groupToHive(GroupModel g) {
    return HiveGroup(
      id: g.id,
      nameJson: jsonEncode(g.name.toJson()),
      icon: g.icon,
      displayOrder: g.displayOrder,
    );
  }
}
