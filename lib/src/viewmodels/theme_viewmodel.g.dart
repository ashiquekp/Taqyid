// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeViewModelHash() => r'95ae60c00137b5f06f8b7ecbae0b29982d4a08f1';

/// Manages the app-wide ThemeMode state, persisted via Hive.
///
/// Copied from [ThemeViewModel].
@ProviderFor(ThemeViewModel)
final themeViewModelProvider =
    AutoDisposeNotifierProvider<ThemeViewModel, ThemeMode>.internal(
      ThemeViewModel.new,
      name: r'themeViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ThemeViewModel = AutoDisposeNotifier<ThemeMode>;
String _$fontSizeViewModelHash() => r'5b4d830e75270cacf8d01ba0a2f13a397ed72ffc';

/// Font scale factor, persisted via Hive
///
/// Copied from [FontSizeViewModel].
@ProviderFor(FontSizeViewModel)
final fontSizeViewModelProvider =
    AutoDisposeNotifierProvider<FontSizeViewModel, double>.internal(
      FontSizeViewModel.new,
      name: r'fontSizeViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fontSizeViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FontSizeViewModel = AutoDisposeNotifier<double>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
