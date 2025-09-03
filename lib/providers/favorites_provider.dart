import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/sample_data.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteIds = {};

  List<Product> get favorites =>
      products.where((p) => _favoriteIds.contains(p.id)).toList();

  void toggleFavorite(Product product) {
    if (_favoriteIds.contains(product.id)) {
      _favoriteIds.remove(product.id);
    } else {
      _favoriteIds.add(product.id);
    }
    notifyListeners();
  }

  bool isFavorite(Product product) => _favoriteIds.contains(product.id);
}
