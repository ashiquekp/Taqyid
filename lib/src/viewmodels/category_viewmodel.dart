import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taqyid/src/models/category_model.dart';
import 'package:taqyid/src/services/api_service.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/viewmodels/language_viewmodel.dart';

part 'category_viewmodel.g.dart';

/// Fetches the root categories for the currently selected language
@riverpod
Future<List<CategoryModel>> categoryRoots(Ref ref) async {
  final lang = ref.watch(selectedLanguageNotifierProvider);
  if (lang == null) return [];

  final cacheKey = 'category_roots_$lang';

  // 1. Try cache
  if (HiveStorageService.hasCached(cacheKey)) {
    final raw = HiveStorageService.getCached(cacheKey);
    if (raw is List) {
      return raw.map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }
  }

  // 2. Fetch from network
  final data = await ApiService.instance.getCategoryRoots(lang);
  final categories = data.map(CategoryModel.fromJson).toList();

  // 3. Cache it
  await HiveStorageService.setCache(
    cacheKey,
    categories.map((c) => c.toJson()).toList(),
  );

  return categories;
}

/// Fetches sub-categories for a given parent category ID
@riverpod
Future<List<CategoryModel>> categoryChildren(
  Ref ref,
  String parentId,
) async {
  final lang = ref.watch(selectedLanguageNotifierProvider);
  if (lang == null) return [];

  final cacheKey = 'category_children_${lang}_$parentId';

  // 1. Try cache
  if (HiveStorageService.hasCached(cacheKey)) {
    final raw = HiveStorageService.getCached(cacheKey);
    if (raw is List) {
      return raw.map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }
  }

  // 2. Fetch from network
  final data = await ApiService.instance.getCategoryList(lang, parentId);
  final categories = data.map(CategoryModel.fromJson).toList();

  // 3. Cache it
  await HiveStorageService.setCache(
    cacheKey,
    categories.map((c) => c.toJson()).toList(),
  );

  return categories;
}
