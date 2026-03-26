// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryRootsHash() => r'97924d843ad3b43c32eed61c056b2f2b6d1e800e';

/// Fetches the root categories for the currently selected language
///
/// Copied from [categoryRoots].
@ProviderFor(categoryRoots)
final categoryRootsProvider =
    AutoDisposeFutureProvider<List<CategoryModel>>.internal(
      categoryRoots,
      name: r'categoryRootsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoryRootsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CategoryRootsRef = AutoDisposeFutureProviderRef<List<CategoryModel>>;
String _$categoryChildrenHash() => r'4dc9ba820c908aa9bf90032d4d4f3c29dd335012';

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

/// Fetches sub-categories for a given parent category ID
///
/// Copied from [categoryChildren].
@ProviderFor(categoryChildren)
const categoryChildrenProvider = CategoryChildrenFamily();

/// Fetches sub-categories for a given parent category ID
///
/// Copied from [categoryChildren].
class CategoryChildrenFamily extends Family<AsyncValue<List<CategoryModel>>> {
  /// Fetches sub-categories for a given parent category ID
  ///
  /// Copied from [categoryChildren].
  const CategoryChildrenFamily();

  /// Fetches sub-categories for a given parent category ID
  ///
  /// Copied from [categoryChildren].
  CategoryChildrenProvider call(String parentId) {
    return CategoryChildrenProvider(parentId);
  }

  @override
  CategoryChildrenProvider getProviderOverride(
    covariant CategoryChildrenProvider provider,
  ) {
    return call(provider.parentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'categoryChildrenProvider';
}

/// Fetches sub-categories for a given parent category ID
///
/// Copied from [categoryChildren].
class CategoryChildrenProvider
    extends AutoDisposeFutureProvider<List<CategoryModel>> {
  /// Fetches sub-categories for a given parent category ID
  ///
  /// Copied from [categoryChildren].
  CategoryChildrenProvider(String parentId)
    : this._internal(
        (ref) => categoryChildren(ref as CategoryChildrenRef, parentId),
        from: categoryChildrenProvider,
        name: r'categoryChildrenProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$categoryChildrenHash,
        dependencies: CategoryChildrenFamily._dependencies,
        allTransitiveDependencies:
            CategoryChildrenFamily._allTransitiveDependencies,
        parentId: parentId,
      );

  CategoryChildrenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentId,
  }) : super.internal();

  final String parentId;

  @override
  Override overrideWith(
    FutureOr<List<CategoryModel>> Function(CategoryChildrenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryChildrenProvider._internal(
        (ref) => create(ref as CategoryChildrenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentId: parentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CategoryModel>> createElement() {
    return _CategoryChildrenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryChildrenProvider && other.parentId == parentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CategoryChildrenRef on AutoDisposeFutureProviderRef<List<CategoryModel>> {
  /// The parameter `parentId` of this provider.
  String get parentId;
}

class _CategoryChildrenProviderElement
    extends AutoDisposeFutureProviderElement<List<CategoryModel>>
    with CategoryChildrenRef {
  _CategoryChildrenProviderElement(super.provider);

  @override
  String get parentId => (origin as CategoryChildrenProvider).parentId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
