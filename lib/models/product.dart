enum AllergenStatus { none, contains, mayContain }

class AllergenInfo {
  final AllergenStatus gluten;
  final AllergenStatus lactose;
  final AllergenStatus nuts;
  final AllergenStatus peanuts;
  final AllergenStatus soy;
  final AllergenStatus egg;

  const AllergenInfo({
    this.gluten = AllergenStatus.none,
    this.lactose = AllergenStatus.none,
    this.nuts = AllergenStatus.none,
    this.peanuts = AllergenStatus.none,
    this.soy = AllergenStatus.none,
    this.egg = AllergenStatus.none,
  });
}

class Product {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final String image;
  final double price;

  /// Favoriler için durum
  bool isFavorite;

  /// 3 durumlu alerjen bilgisi
  final AllergenInfo allergens;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.image,
    required this.price,
    this.isFavorite = false,
    this.allergens = const AllergenInfo(),
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Category {
  final String id;
  final String title;
  final String image;

  const Category({
    required this.id,
    required this.title,
    required this.image,
  });
}