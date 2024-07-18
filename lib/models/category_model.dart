class CategoryModel {
  final String category;
  String? description;
  CategoryModel({required this.category, this.description});
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'description': description,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    return CategoryModel(
      category: data['category'],
      description: data['description'] ?? '',
    );
  }
}
///djfkdjfkdjfdjfk