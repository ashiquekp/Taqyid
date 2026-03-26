// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadith_detail_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hadithDetailHash() => r'9e54fc72ff0b7d11d5563aef4f3cbd7c3067be81';

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

/// Fetches a detailed single Hadith
///
/// Copied from [hadithDetail].
@ProviderFor(hadithDetail)
const hadithDetailProvider = HadithDetailFamily();

/// Fetches a detailed single Hadith
///
/// Copied from [hadithDetail].
class HadithDetailFamily extends Family<AsyncValue<HadithDetailModel>> {
  /// Fetches a detailed single Hadith
  ///
  /// Copied from [hadithDetail].
  const HadithDetailFamily();

  /// Fetches a detailed single Hadith
  ///
  /// Copied from [hadithDetail].
  HadithDetailProvider call(String hadithId) {
    return HadithDetailProvider(hadithId);
  }

  @override
  HadithDetailProvider getProviderOverride(
    covariant HadithDetailProvider provider,
  ) {
    return call(provider.hadithId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hadithDetailProvider';
}

/// Fetches a detailed single Hadith
///
/// Copied from [hadithDetail].
class HadithDetailProvider
    extends AutoDisposeFutureProvider<HadithDetailModel> {
  /// Fetches a detailed single Hadith
  ///
  /// Copied from [hadithDetail].
  HadithDetailProvider(String hadithId)
    : this._internal(
        (ref) => hadithDetail(ref as HadithDetailRef, hadithId),
        from: hadithDetailProvider,
        name: r'hadithDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$hadithDetailHash,
        dependencies: HadithDetailFamily._dependencies,
        allTransitiveDependencies:
            HadithDetailFamily._allTransitiveDependencies,
        hadithId: hadithId,
      );

  HadithDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hadithId,
  }) : super.internal();

  final String hadithId;

  @override
  Override overrideWith(
    FutureOr<HadithDetailModel> Function(HadithDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HadithDetailProvider._internal(
        (ref) => create(ref as HadithDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hadithId: hadithId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<HadithDetailModel> createElement() {
    return _HadithDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HadithDetailProvider && other.hadithId == hadithId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hadithId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HadithDetailRef on AutoDisposeFutureProviderRef<HadithDetailModel> {
  /// The parameter `hadithId` of this provider.
  String get hadithId;
}

class _HadithDetailProviderElement
    extends AutoDisposeFutureProviderElement<HadithDetailModel>
    with HadithDetailRef {
  _HadithDetailProviderElement(super.provider);

  @override
  String get hadithId => (origin as HadithDetailProvider).hadithId;
}

String _$hadithNoteNotifierHash() =>
    r'b784bd4175c218902ba046a965e8ad2254d60f9a';

abstract class _$HadithNoteNotifier
    extends BuildlessAutoDisposeNotifier<String?> {
  late final String hadithId;

  String? build(String hadithId);
}

/// A provider to manage user's notes for a specific hadith
///
/// Copied from [HadithNoteNotifier].
@ProviderFor(HadithNoteNotifier)
const hadithNoteNotifierProvider = HadithNoteNotifierFamily();

/// A provider to manage user's notes for a specific hadith
///
/// Copied from [HadithNoteNotifier].
class HadithNoteNotifierFamily extends Family<String?> {
  /// A provider to manage user's notes for a specific hadith
  ///
  /// Copied from [HadithNoteNotifier].
  const HadithNoteNotifierFamily();

  /// A provider to manage user's notes for a specific hadith
  ///
  /// Copied from [HadithNoteNotifier].
  HadithNoteNotifierProvider call(String hadithId) {
    return HadithNoteNotifierProvider(hadithId);
  }

  @override
  HadithNoteNotifierProvider getProviderOverride(
    covariant HadithNoteNotifierProvider provider,
  ) {
    return call(provider.hadithId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hadithNoteNotifierProvider';
}

/// A provider to manage user's notes for a specific hadith
///
/// Copied from [HadithNoteNotifier].
class HadithNoteNotifierProvider
    extends AutoDisposeNotifierProviderImpl<HadithNoteNotifier, String?> {
  /// A provider to manage user's notes for a specific hadith
  ///
  /// Copied from [HadithNoteNotifier].
  HadithNoteNotifierProvider(String hadithId)
    : this._internal(
        () => HadithNoteNotifier()..hadithId = hadithId,
        from: hadithNoteNotifierProvider,
        name: r'hadithNoteNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$hadithNoteNotifierHash,
        dependencies: HadithNoteNotifierFamily._dependencies,
        allTransitiveDependencies:
            HadithNoteNotifierFamily._allTransitiveDependencies,
        hadithId: hadithId,
      );

  HadithNoteNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.hadithId,
  }) : super.internal();

  final String hadithId;

  @override
  String? runNotifierBuild(covariant HadithNoteNotifier notifier) {
    return notifier.build(hadithId);
  }

  @override
  Override overrideWith(HadithNoteNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: HadithNoteNotifierProvider._internal(
        () => create()..hadithId = hadithId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        hadithId: hadithId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<HadithNoteNotifier, String?>
  createElement() {
    return _HadithNoteNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HadithNoteNotifierProvider && other.hadithId == hadithId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, hadithId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HadithNoteNotifierRef on AutoDisposeNotifierProviderRef<String?> {
  /// The parameter `hadithId` of this provider.
  String get hadithId;
}

class _HadithNoteNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<HadithNoteNotifier, String?>
    with HadithNoteNotifierRef {
  _HadithNoteNotifierProviderElement(super.provider);

  @override
  String get hadithId => (origin as HadithNoteNotifierProvider).hadithId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
