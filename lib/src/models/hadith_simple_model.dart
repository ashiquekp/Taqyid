/// A simplified model for items in the Hadith List API response
class HadithSimpleModel {
  const HadithSimpleModel({
    required this.id,
    required this.title,
    required this.translations,
  });

  final String id;
  final String title;
  final List<String> translations;

  factory HadithSimpleModel.fromJson(Map<String, dynamic> json) {
    return HadithSimpleModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      translations: (json['translations'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'translations': translations,
      };

  @override
  String toString() => 'HadithSimpleModel(id: $id, title: $title)';
}

/// Metadata for pagination in the Hadith List API
class PaginationMeta {
  const PaginationMeta({
    required this.currentPage,
    required this.lastPage,
    required this.totalItems,
    required this.perPage,
  });

  final int currentPage;
  final int lastPage;
  final int totalItems;
  final int perPage;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      totalItems: json['total_items'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 20,
    );
  }

  bool get hasNextPage => currentPage < lastPage;
}

/// Wrapper for paginated Hadith results
class PaginatedHadiths {
  const PaginatedHadiths({
    required this.data,
    required this.meta,
  });

  final List<HadithSimpleModel> data;
  final PaginationMeta meta;

  factory PaginatedHadiths.fromJson(Map<String, dynamic> json) {
    return PaginatedHadiths(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => HadithSimpleModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      meta: PaginationMeta.fromJson(Map<String, dynamic>.from(json['meta'] ?? {})),
    );
  }
}
