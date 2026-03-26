import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taqyid/src/models/hadith_simple_model.dart';
import 'package:taqyid/src/services/api_service.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';
import 'package:taqyid/src/viewmodels/language_viewmodel.dart';
import 'package:taqyid/src/viewmodels/category_viewmodel.dart';

part 'daily_hadith_viewmodel.g.dart';

class StreakData {
  const StreakData({
    required this.currentStreak,
    required this.longestStreak,
    required this.lastReadDate,
  });

  final int currentStreak;
  final int longestStreak;
  final String? lastReadDate;
}

@riverpod
class StreakNotifier extends _$StreakNotifier {
  @override
  StreakData build() {
    return StreakData(
      currentStreak: HiveStorageService.currentStreak,
      longestStreak: HiveStorageService.longestStreak,
      lastReadDate: HiveStorageService.settings.get(HiveKeys.lastDailyHadithDate) as String?,
    );
  }

  Future<void> markDailyRead() async {
    final now = DateTime.now();
    final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    
    final lastRead = state.lastReadDate;
    
    if (lastRead == todayStr) {
      // Already read today
      return;
    }

    int newCurrentStreak = state.currentStreak;
    int newLongestStreak = state.longestStreak;

    if (lastRead != null) {
      final lastDate = DateTime.parse(lastRead);
      final difference = now.difference(lastDate).inDays;
      
      if (difference == 1) {
        // Read yesterday, increment streak
        newCurrentStreak++;
      } else if (difference > 1) {
        // Missed a day, reset streak
        newCurrentStreak = 1;
      }
    } else {
      newCurrentStreak = 1;
    }

    if (newCurrentStreak > newLongestStreak) {
      newLongestStreak = newCurrentStreak;
    }

    await HiveStorageService.streak.put(HiveKeys.currentStreak, newCurrentStreak);
    await HiveStorageService.streak.put(HiveKeys.longestStreak, newLongestStreak);
    await HiveStorageService.settings.put(HiveKeys.lastDailyHadithDate, todayStr);

    state = StreakData(
      currentStreak: newCurrentStreak,
      longestStreak: newLongestStreak,
      lastReadDate: todayStr,
    );
  }
}

@riverpod
Future<HadithSimpleModel?> dailyHadith(Ref ref) async {
  final lang = ref.watch(selectedLanguageNotifierProvider);
  if (lang == null) return null;

  // Derive a stable "Day of the Year" index
  final now = DateTime.now();
  final dayOfYear = int.parse(now.difference(DateTime(now.year, 1, 1)).inDays.toString());

  final cacheKey = 'daily_hadith_${lang}_$dayOfYear';
  if (HiveStorageService.hasCached(cacheKey)) {
    final raw = HiveStorageService.getCached(cacheKey);
    if (raw is Map) {
      return HadithSimpleModel.fromJson(Map<String, dynamic>.from(raw));
    }
  }

  // Fetch roots to find a category
  final roots = await ref.read(categoryRootsProvider.future);
  if (roots.isEmpty) return null;

  // Use day of year to deterministically pick a category and a page
  final catIndex = dayOfYear % roots.length;
  final category = roots[catIndex];

  // Fetch hadiths from that category
  final data = await ApiService.instance.getHadithsList(
    lang: lang,
    categoryId: category.id,
    page: 1,
  );
  
  final items = (data['data'] as List<dynamic>?)
      ?.map((e) => HadithSimpleModel.fromJson(Map<String, dynamic>.from(e)))
      .toList() ?? [];

  if (items.isEmpty) return null;

  final itemIndex = dayOfYear % items.length;
  final daily = items[itemIndex];

  await HiveStorageService.setCache(cacheKey, daily.toJson());
  return daily;
}
