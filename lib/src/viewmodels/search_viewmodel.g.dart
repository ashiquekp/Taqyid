// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchNotifierHash() => r'96306e682ca88b87f7ab819de9b102344c229782';

/// Manages paginated search results
///
/// Copied from [SearchNotifier].
@ProviderFor(SearchNotifier)
final searchNotifierProvider =
    AutoDisposeNotifierProvider<SearchNotifier, SearchState>.internal(
      SearchNotifier.new,
      name: r'searchNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchNotifier = AutoDisposeNotifier<SearchState>;
String _$searchHistoryHash() => r'1ec7111f8b1601a071056d5c52732b3d74ccf0d9';

/// Provides the list of recent search entries from Hive
///
/// Copied from [SearchHistory].
@ProviderFor(SearchHistory)
final searchHistoryProvider =
    AutoDisposeNotifierProvider<SearchHistory, List<String>>.internal(
      SearchHistory.new,
      name: r'searchHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchHistory = AutoDisposeNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
