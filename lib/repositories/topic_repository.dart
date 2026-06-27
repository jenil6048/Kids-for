import 'dart:convert';
import 'dart:developer' as developer;
import 'package:hive/hive.dart';
import '../hive/adapters/hive_topic.dart';
import '../hive/hive_service.dart';
import '../models/localized_text.dart';
import '../models/topic_model.dart';
import '../repositories/config_repository.dart';
import '../services/supabase_service.dart';

/// Repository for topics within a category.
///
/// Flow for getTopics():
///   1. Open (or reuse) the per-category Hive box.
///   2. If box is empty OR config says stale → full Supabase fetch → replace Hive.
///   3. Otherwise → serve requested page from Hive.
class TopicRepository {
  TopicRepository._internal();
  static final TopicRepository instance = TopicRepository._internal();

  /// Returns topics for [categoryKey], with pagination.
  ///
  /// [limit] and [offset] control which slice of topics to return.
  /// On a cache miss the ENTIRE category is downloaded (≤200 items).
  Future<List<TopicModel>> getTopics(
    String categoryKey,
    int categoryId, {
    int limit = 30,
    int offset = 0,
  }) async {
    developer.log('TopicRepository: getTopics('
        'key=$categoryKey, id=$categoryId, limit=$limit, offset=$offset)');

    final box = await HiveService.instance.openTopicBox(categoryKey);
    final stale = ConfigRepository.instance.isStale(categoryKey);
    final needsFetch = box.isEmpty || stale;

    developer.log('TopicRepository: Cache Status for "$categoryKey" - '
        'box.isEmpty=${box.isEmpty}, '
        'box.length=${box.length}, '
        'isStale=$stale, '
        'needsFetch=$needsFetch');

    if (needsFetch) {
      developer.log('TopicRepository: CACHE MISS OR STALE for "$categoryKey". Fetching from Supabase...');
      try {
        final allTopics = await _fetchAllFromSupabase(categoryKey, categoryId);
        if (allTopics.isNotEmpty) {
          await _replaceHive(box, allTopics);
          await ConfigRepository.instance.markSynced(categoryKey);
          developer.log('TopicRepository: Stored ${allTopics.length} topics '
              'in Hive for "$categoryKey"');
        } else if (box.isNotEmpty) {
          developer.log('TopicRepository: Supabase returned 0 — '
              'keeping existing ${box.length} cached topics');
        }
      } catch (e) {
        developer.log('TopicRepository: Supabase fetch failed: $e');
        if (box.isEmpty) {
          // Nothing to serve at all
          return [];
        }
        // Fall through and serve from Hive
        developer.log('TopicRepository: Serving stale Hive data for "$categoryKey"');
      }
    } else {
      developer.log('TopicRepository: Cache hit for "$categoryKey" '
          '(${box.length} topics stored)');
    }

    final data = _pageFromHive(box, limit, offset);
    print('--- TOPICS FROM HIVE ($categoryKey) ---');
    print('Offset: $offset, Limit: $limit, Count: ${data.length}');
    for (var topic in data) {
      print('Topic: ${topic.topicKey}, Name: ${topic.name.en}');
    }
    print('-----------------------------------------');
    return data;
  }

  // ---------------------------------------------------------------------------
  // Supabase helper — fetches ALL pages for a category
  // ---------------------------------------------------------------------------

  Future<List<TopicModel>> _fetchAllFromSupabase(
      String categoryKey, int categoryId) async {
    final List<TopicModel> all = [];
    const pageSize = 100;
    int offset = 0;

    while (true) {
      final page = await SupabaseService.instance.getTopicsForCategory(
        categoryKey,
        categoryId,
        limit: pageSize,
        offset: offset,
      );
      print('--- TOPICS FROM SUPABASE ($categoryKey, page offset $offset) ---');
      for (var topic in page) {
        print('Topic: ${topic.topicKey}, Name: ${topic.name.en}');
      }
      print('------------------------------------------------------------');
      all.addAll(page);
      if (page.length < pageSize) break; // last page
      offset += pageSize;
    }

    all.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    developer.log('TopicRepository: Fetched total ${all.length} topics for "$categoryKey"');
    return all;
  }

  // ---------------------------------------------------------------------------
  // Hive helpers
  // ---------------------------------------------------------------------------

  /// Replace all entries in [box] with [topics].
  Future<void> _replaceHive(
      Box<HiveTopic> box, List<TopicModel> topics) async {
    await box.clear();
    final Map<String, HiveTopic> entries = {};
    for (final t in topics) {
      entries[t.topicKey] = _modelToHive(t);
    }
    await box.putAll(entries);
  }

  /// Return a sorted page slice from [box].
  List<TopicModel> _pageFromHive(
      Box<HiveTopic> box, int limit, int offset) {
    final sorted = box.values.toList()
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    final end = (offset + limit).clamp(0, sorted.length);
    if (offset >= sorted.length) return [];
    return sorted.sublist(offset, end).map(_hiveToModel).toList();
  }

  HiveTopic _modelToHive(TopicModel m) {
    return HiveTopic(
      id: m.id,
      topicKey: m.topicKey,
      categoryId: m.categoryId,
      nameJson: jsonEncode(m.name.toJson()),
      svgPath: m.svgPath,
      imagePath: m.imagePath,
      lottiePath: m.lottiePath,
      narrationJson: jsonEncode(m.narration.toJson()),
      explanationJson: jsonEncode(m.explanation.toJson()),
      factJson: jsonEncode(m.fact.toJson()),
      gameType: m.gameType,
      isFree: m.isFree,
      displayOrder: m.displayOrder,
    );
  }

  TopicModel _hiveToModel(HiveTopic h) {
    LocalizedText _decode(String json) {
      return LocalizedText.fromJson(
          Map<String, dynamic>.from(jsonDecode(json) as Map));
    }

    return TopicModel(
      id: h.id,
      topicKey: h.topicKey,
      categoryId: h.categoryId,
      name: _decode(h.nameJson),
      svgPath: h.svgPath,
      imagePath: h.imagePath,
      lottiePath: h.lottiePath,
      narration: _decode(h.narrationJson),
      explanation: _decode(h.explanationJson),
      fact: _decode(h.factJson),
      gameType: h.gameType,
      isFree: h.isFree,
      displayOrder: h.displayOrder,
    );
  }

  /// Returns the total number of locally-cached topics for [categoryKey].
  Future<int> cachedCount(String categoryKey) async {
    final box = await HiveService.instance.openTopicBox(categoryKey);
    return box.length;
  }

  /// Force-clear the cache for a specific category.
  Future<void> invalidate(String categoryKey) async {
    await HiveService.instance.clearTopicBox(categoryKey);
    developer.log('TopicRepository: Invalidated cache for "$categoryKey"');
  }
}
