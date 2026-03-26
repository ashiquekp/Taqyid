import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:taqyid/src/services/hive_storage_service.dart';

part 'theme_viewmodel.g.dart';

/// Manages the app-wide ThemeMode state, persisted via Hive.
@riverpod
class ThemeViewModel extends _$ThemeViewModel {
  @override
  ThemeMode build() {
    final saved = HiveStorageService.themeMode;
    return _fromString(saved);
  }

  Future<void> setTheme(ThemeMode mode) async {
    await HiveStorageService.setThemeMode(_toString(mode));
    state = mode;
  }

  void toggleTheme() {
    final next = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setTheme(next);
  }

  ThemeMode _fromString(String s) {
    switch (s) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _toString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

/// Font scale factor, persisted via Hive
@riverpod
class FontSizeViewModel extends _$FontSizeViewModel {
  @override
  double build() => HiveStorageService.fontSize;

  Future<void> setFontSize(double size) async {
    await HiveStorageService.setFontSize(size);
    state = size;
  }
}
