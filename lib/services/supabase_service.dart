import 'dart:developer' as developer;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category_model.dart';
import '../models/group_model.dart';
import '../models/topic_model.dart';

class SupabaseService {
  SupabaseService._internal();
  static final SupabaseService instance = SupabaseService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  Future<List<CategoryModel>> getCategories() async {
    developer.log('SupabaseService: Starting getCategories()...');
    try {
      final List<dynamic> response = await _client
          .from('categories')
          .select('*, groups(*)')
          .order('display_order');
      
      developer.log('SupabaseService: getCategories() Response: $response');
      
      final results = response.map((json) => CategoryModel.fromJson(json as Map<String, dynamic>)).toList();
      developer.log('SupabaseService: getCategories() parsed ${results.length} categories.');
      return results;
    } catch (e) {
      developer.log('SupabaseService ERROR: getCategories(): $e');
      return [];
    }
  }

  Future<List<GroupModel>> getGroups() async {
    developer.log('SupabaseService: Starting getGroups()...');
    try {
      final List<dynamic> response = await _client
          .from('groups')
          .select('*');
      
      developer.log('SupabaseService: getGroups() Response: $response');
      
      final results = response.map((json) => GroupModel.fromJson(json as Map<String, dynamic>)).toList();
      developer.log('SupabaseService: getGroups() parsed ${results.length} groups.');
      return results;
    } catch (e) {
      developer.log('SupabaseService ERROR: getGroups(): $e');
      return [];
    }
  }

  Future<List<TopicModel>> getTopicsForCategory(String categoryKey, int categoryId, {int limit = 30, int offset = 0}) async {
    developer.log('SupabaseService: Starting getTopicsForCategory(categoryKey: $categoryKey, categoryId: $categoryId, limit: $limit, offset: $offset)...');

    // Helper to query a table and safely catch exceptions
    Future<List<TopicModel>?> tryQueryTable(String tableName, {required bool applyFilter}) async {
      developer.log('SupabaseService: tryQueryTable(tableName: $tableName, applyFilter: $applyFilter, range: $offset to ${offset + limit - 1})...');
      try {
        var query = _client.from(tableName).select('*');
        if (applyFilter) {
          query = query.eq('category_id', categoryId);
        }
        
        final List<dynamic> response = await query
            .order('display_order')
            .range(offset, offset + limit - 1);
        
        developer.log('SupabaseService: Response from "$tableName": $response');
        
        if (response.isNotEmpty) {
          developer.log('SupabaseService: Successfully fetched ${response.length} items from "$tableName" (filter applied: $applyFilter).');
          return response.map((json) => TopicModel.fromJson(json as Map<String, dynamic>)).toList();
        } else {
          developer.log('SupabaseService: No items found in "$tableName" (filter applied: $applyFilter).');
        }
      } catch (e) {
        developer.log('SupabaseService: Query info/error on "$tableName" (filter applied: $applyFilter): $e');
      }
      return null;
    }

    // Generate table names to try (exact name, then alternative singular/plural name)
    List<String> tablesToTry = [categoryKey];
    String alternativeKey = categoryKey;
    if (categoryKey.endsWith('s')) {
      alternativeKey = categoryKey.substring(0, categoryKey.length - 1);
    } else {
      alternativeKey = '${categoryKey}s';
    }
    if (!tablesToTry.contains(alternativeKey)) {
      tablesToTry.add(alternativeKey);
    }
    
    // Specifically handle 'alphabet' vs 'alphabets' if needed
    if (categoryKey == 'alphabet' && !tablesToTry.contains('alphabets')) {
      tablesToTry.add('alphabets');
    }

    developer.log('SupabaseService: Tables to try: $tablesToTry');

    // Step 1: Query tables WITH category_id filter, ordered by display_order
    for (var tableName in tablesToTry) {
      final results = await tryQueryTable(tableName, applyFilter: true);
      if (results != null && results.isNotEmpty) {
        // Double check sorting in Dart just to be 100% sure as per user request
        results.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return results;
      }
    }

    // Step 2: Query tables WITHOUT category_id filter (unfiltered fallback), ordered by display_order
    for (var tableName in tablesToTry) {
      final results = await tryQueryTable(tableName, applyFilter: false);
      if (results != null && results.isNotEmpty) {
        developer.log('SupabaseService: Mismatched/Unlinked category_id detected in table "$tableName". Returning ordered unfiltered rows.');
        results.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        return results;
      }
    }

    developer.log('SupabaseService: Both queries returned 0 results for $categoryKey. Returning empty list.');
    return [];
  }
}
