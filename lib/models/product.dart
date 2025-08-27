class Product {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final double price;
  final String categoryId;
  final bool isIced;
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.price,
    required this.categoryId,
    this.isIced = false,
  });
}

class Category {
  final String id;
  final String title;
  final String emoji;
  const Category({required this.id, required this.title, required this.emoji});
}
