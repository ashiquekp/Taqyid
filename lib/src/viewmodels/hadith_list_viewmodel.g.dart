// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadith_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hadithListNotifierHash() =>
    r'01ab0f2e27aec25316f09e8d37e48b5417e833e2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$HadithListNotifier
    extends BuildlessAutoDisposeNotifier<HadithListState> {
  late final String categoryId;

  HadithListState build(String categoryId);
}

/// Manages paginated list of hadiths for a specific category
///
/// Copied from [HadithListNotifier].
@ProviderFor(HadithListNotifier)
const hadithListNotifierProvider = HadithListNotifierFamily();

/// Manages paginated list of hadiths for a specific category
///
/// Copied from [HadithListNotifier].
class HadithListNotifierFamily extends Family<HadithListState> {
  /// Manages paginated list of hadiths for a specific category
  ///
  /// Copied from [HadithListNotifier].
  const HadithListNotifierFamily();

  /// Manages paginated list of hadiths for a specific category
  ///
  /// Copied from [HadithListNotifier].
  HadithListNotifierProvider call(String categoryId) {
    return HadithListNotifierProvider(categoryId);
  }

  @override
  HadithListNotifierProvider getProviderOverride(
    covariant HadithListNotifierProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hadithListNotifierProvider';
}

/// Manages paginated list of hadiths for a specific category
///
/// Copied from [HadithListNotifier].
class HadithListNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<HadithListNotifier, HadithListState> {
  /// Manages paginated list of hadiths for a specific category
  ///
  /// Copied from [HadithListNotifier].
  HadithListNotifierProvider(String categoryId)
    : this._internal(
        () => HadithListNotifier()..categoryId = categoryId,
        from: hadithListNotifierProvider,
        name: r'hadithListNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$hadithListNotifierHash,
        dependencies: HadithListNotifierFamily._dependencies,
        allTransitiveDependencies:
            HadithListNotifierFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  HadithListNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final String categoryId;

  @override
  HadithListState runNotifierBuild(covariant HadithListNotifier notifier) {
    return notifier.build(categoryId);
  }

  @override
  Override overrideWith(HadithListNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: HadithListNotifierProvider._internal(
        () => create()..categoryId = categoryId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<HadithListNotifier, HadithListState>
  createElement() {
    return _HadithListNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HadithListNotifierProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HadithListNotifierRef on AutoDisposeNotifierProviderRef<HadithListState> {
  /// The parameter `categoryId` of this provider.
  String get categoryId;
}

class _HadithListNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<HadithListNotifier, HadithListState>
    with HadithListNotifierRef {
  _HadithListNotifierProviderElement(super.provider);

  @override
  String get categoryId => (origin as HadithListNotifierProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
