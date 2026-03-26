// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$languagesHash() => r'bb9b6bf84554f52279c7be1b825c3154b30f6c9f';

/// Fetches all available languages from the API with Hive caching.
///
/// Copied from [languages].
@ProviderFor(languages)
final languagesProvider =
    AutoDisposeFutureProvider<List<LanguageModel>>.internal(
      languages,
      name: r'languagesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$languagesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LanguagesRef = AutoDisposeFutureProviderRef<List<LanguageModel>>;
String _$selectedLanguageNotifierHash() =>
    r'3b175583f360cda1a4fec84bc12f216040f0ae5e';

/// Keeps the currently selected language code in memory + synced with Hive.
///
/// Copied from [SelectedLanguageNotifier].
@ProviderFor(SelectedLanguageNotifier)
final selectedLanguageNotifierProvider =
    AutoDisposeNotifierProvider<SelectedLanguageNotifier, String?>.internal(
      SelectedLanguageNotifier.new,
      name: r'selectedLanguageNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedLanguageNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedLanguageNotifier = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
