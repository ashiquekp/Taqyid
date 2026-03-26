// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookmarksNotifierHash() => r'331e9de74fb38745a1272a3a8ccc00fcb0a497f2';

/// Provides a list of bookmarked hadiths
///
/// Copied from [BookmarksNotifier].
@ProviderFor(BookmarksNotifier)
final bookmarksNotifierProvider =
    AutoDisposeNotifierProvider<
      BookmarksNotifier,
      List<HadithSimpleModel>
    >.internal(
      BookmarksNotifier.new,
      name: r'bookmarksNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$bookmarksNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BookmarksNotifier = AutoDisposeNotifier<List<HadithSimpleModel>>;
String _$notesNotifierHash() => r'f807fe1d314a402a0500e890b52eafae166e4de0';

/// Provides a map of notes where key=hadithId and value=note text
///
/// Copied from [NotesNotifier].
@ProviderFor(NotesNotifier)
final notesNotifierProvider =
    AutoDisposeNotifierProvider<NotesNotifier, Map<String, String>>.internal(
      NotesNotifier.new,
      name: r'notesNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notesNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotesNotifier = AutoDisposeNotifier<Map<String, String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
