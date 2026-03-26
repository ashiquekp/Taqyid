import 'package:hive_flutter/hive_flutter.dart';

/// Keys for Hive boxes and fields
class HiveKeys {
  HiveKeys._();

  // Box names
  static const String settingsBox = 'settings';
  static const String bookmarksBox = 'bookmarks';
  static const String notesBox = 'notes';
  static const String cacheBox = 'cache';
  static const String searchHistoryBox = 'search_history';
  static const String collectionsBox = 'collections';
  static const String streakBox = 'streak';

  // Settings keys
  static const String selectedLanguage = 'selected_language';
  static const String themeMode = 'theme_mode';
  static const String fontSize = 'font_size';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String showArabicToggle = 'show_arabic';
  static const String isFirstLaunch = 'is_first_launch';
  static const String lastDailyHadithDate = 'last_daily_date';
  static const String currentStreak = 'current_streak';
  static const String longestStreak = 'longest_streak';
}

/// Hive storage service for all local persistence
class HiveStorageService {
  HiveStorageService._();

  static late Box<dynamic> _settingsBox;
  static late Box<dynamic> _bookmarksBox;
  static late Box<dynamic> _notesBox;
  static late Box<dynamic> _cacheBox;
  static late Box<dynamic> _searchHistoryBox;
  static late Box<dynamic> _collectionsBox;
  static late Box<dynamic> _streakBox;

  /// Initialize all Hive boxes - call this before runApp
  static Future<void> init() async {
    await Hive.initFlutter();
    _settingsBox = await Hive.openBox(HiveKeys.settingsBox);
    _bookmarksBox = await Hive.openBox(HiveKeys.bookmarksBox);
    _notesBox = await Hive.openBox(HiveKeys.notesBox);
    _cacheBox = await Hive.openBox(HiveKeys.cacheBox);
    _searchHistoryBox = await Hive.openBox(HiveKeys.searchHistoryBox);
    _collectionsBox = await Hive.openBox(HiveKeys.collectionsBox);
    _streakBox = await Hive.openBox(HiveKeys.streakBox);
  }

  // ============ Settings ============
  static Box<dynamic> get settings => _settingsBox;

  static String? get selectedLanguage =>
      _settingsBox.get(HiveKeys.selectedLanguage);

  static Future<void> setSelectedLanguage(String code) =>
      _settingsBox.put(HiveKeys.selectedLanguage, code);

  static String get themeMode =>
      _settingsBox.get(HiveKeys.themeMode, defaultValue: 'system') as String;

  static Future<void> setThemeMode(String mode) =>
      _settingsBox.put(HiveKeys.themeMode, mode);

  static double get fontSize =>
      (_settingsBox.get(HiveKeys.fontSize, defaultValue: 16.0) as num).toDouble();

  static Future<void> setFontSize(double size) =>
      _settingsBox.put(HiveKeys.fontSize, size);

  static bool get notificationsEnabled =>
      _settingsBox.get(HiveKeys.notificationsEnabled, defaultValue: true) as bool;

  static Future<void> setNotificationsEnabled(bool enabled) =>
      _settingsBox.put(HiveKeys.notificationsEnabled, enabled);

  static bool get isFirstLaunch =>
      _settingsBox.get(HiveKeys.isFirstLaunch, defaultValue: true) as bool;

  static Future<void> setFirstLaunchDone() =>
      _settingsBox.put(HiveKeys.isFirstLaunch, false);

  static bool get showArabic =>
      _settingsBox.get(HiveKeys.showArabicToggle, defaultValue: false) as bool;

  static Future<void> setShowArabic(bool show) =>
      _settingsBox.put(HiveKeys.showArabicToggle, show);

  // ============ Cache ============
  static Box<dynamic> get cache => _cacheBox;

  static dynamic getCached(String key) => _cacheBox.get(key);

  static Future<void> setCache(String key, dynamic value) =>
      _cacheBox.put(key, value);

  static bool hasCached(String key) => _cacheBox.containsKey(key);

  static Future<void> clearCache() => _cacheBox.clear();

  // ============ Bookmarks ============
  static Box<dynamic> get bookmarks => _bookmarksBox;

  static bool isBookmarked(String hadithId) =>
      _bookmarksBox.containsKey(hadithId);

  static Future<void> addBookmark(String hadithId, Map<String, dynamic> data) =>
      _bookmarksBox.put(hadithId, data);

  static Future<void> removeBookmark(String hadithId) =>
      _bookmarksBox.delete(hadithId);

  static List<Map<String, dynamic>> getAllBookmarks() {
    return _bookmarksBox.values
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // ============ Notes ============
  static Box<dynamic> get notes => _notesBox;

  static String? getNote(String hadithId) =>
      _notesBox.get(hadithId) as String?;

  static Future<void> saveNote(String hadithId, String note) =>
      _notesBox.put(hadithId, note);

  static Future<void> deleteNote(String hadithId) =>
      _notesBox.delete(hadithId);

  // ============ Search History ============
  static Box<dynamic> get searchHistory => _searchHistoryBox;

  static List<String> getSearchHistory() {
    final raw = _searchHistoryBox.get('history');
    if (raw == null) return [];
    return (raw as List).cast<String>();
  }

  static Future<void> addSearchEntry(String query) async {
    final history = getSearchHistory();
    history.remove(query); // deduplicate
    history.insert(0, query);
    if (history.length > 20) history.removeLast();
    await _searchHistoryBox.put('history', history);
  }

  static Future<void> clearSearchHistory() =>
      _searchHistoryBox.put('history', <String>[]);

  // ============ Collections ============
  static Box<dynamic> get collections => _collectionsBox;

  // ============ Streaks ============
  static Box<dynamic> get streak => _streakBox;

  static int get currentStreak =>
      _streakBox.get(HiveKeys.currentStreak, defaultValue: 0) as int;

  static int get longestStreak =>
      _streakBox.get(HiveKeys.longestStreak, defaultValue: 0) as int;
}
