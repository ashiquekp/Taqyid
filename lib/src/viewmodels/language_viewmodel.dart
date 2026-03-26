import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taqyid/src/models/language_model.dart';
import 'package:taqyid/src/services/api_service.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';

part 'language_viewmodel.g.dart';

// ─── Provider for the selected language code ───────────────────────────────

/// Keeps the currently selected language code in memory + synced with Hive.
@riverpod
class SelectedLanguageNotifier extends _$SelectedLanguageNotifier {
  @override
  String? build() => HiveStorageService.selectedLanguage;

  Future<void> select(String code) async {
    await HiveStorageService.setSelectedLanguage(code);
    state = code;
  }
}

// ─── Provider for the languages list ──────────────────────────────────────

/// Fetches all available languages from the API with Hive caching.
@riverpod
Future<List<LanguageModel>> languages(Ref ref) async {
  const cacheKey = 'languages_list';

  // Return from cache if available
  if (HiveStorageService.hasCached(cacheKey)) {
    final raw = HiveStorageService.getCached(cacheKey);
    if (raw is List) {
      return raw
          .whereType<Map>()
          .map((e) => LanguageModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
  }

  // Fetch from network
  final data = await ApiService.instance.getLanguages();
  final langs = data.map(LanguageModel.fromJson).toList();

  // Persist to cache
  await HiveStorageService.setCache(
    cacheKey,
    langs.map((l) => l.toJson()).toList(),
  );

  return langs;
}
