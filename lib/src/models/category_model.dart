/// Category model from HadeethEnc API
class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.title,
    required this.hadeethsCount,
    this.parentId,
  });

  final String id;
  final String title;
  final String hadeethsCount;
  final String? parentId;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      hadeethsCount: json['hadeeths_count']?.toString() ?? '0',
      parentId: json['parent_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'hadeeths_count': hadeethsCount,
        if (parentId != null) 'parent_id': parentId,
      };

  @override
  String toString() => 'CategoryModel(id: $id, title: $title)';
}
