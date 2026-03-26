import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taqyid/src/models/hadith_detail_model.dart';
import 'package:taqyid/src/services/api_service.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/viewmodels/language_viewmodel.dart';

part 'hadith_detail_viewmodel.g.dart';

/// Fetches a detailed single Hadith
@riverpod
Future<HadithDetailModel> hadithDetail(Ref ref, String hadithId) async {
  final lang = ref.watch(selectedLanguageNotifierProvider);
  if (lang == null) throw Exception('Language not selected');

  final cacheKey = 'hadith_detail_${lang}_$hadithId';

  // 1. Check cache for offline view or quick loading
  if (HiveStorageService.hasCached(cacheKey)) {
    final raw = HiveStorageService.getCached(cacheKey);
    if (raw is Map) {
      return HadithDetailModel.fromJson(Map<String, dynamic>.from(raw));
    }
  }

  // 2. Fetch from network
  final data = await ApiService.instance.getHadeethOne(lang, hadithId);
  final hadith = HadithDetailModel.fromJson(data);

  // 3. Cache it
  await HiveStorageService.setCache(cacheKey, hadith.toJson());

  return hadith;
}

/// A provider to manage user's notes for a specific hadith
@riverpod
class HadithNoteNotifier extends _$HadithNoteNotifier {
  @override
  String? build(String hadithId) {
    return HiveStorageService.getNote(hadithId);
  }

  Future<void> saveNote(String text) async {
    if (text.trim().isEmpty) {
      await HiveStorageService.deleteNote(hadithId);
      state = null;
    } else {
      await HiveStorageService.saveNote(hadithId, text);
      state = text;
    }
  }
}
