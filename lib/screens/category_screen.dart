import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../widgets/product_card.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryId;
  const CategoryScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final items = products.where((p) => p.categoryId == categoryId).toList();
    final title = categories.firstWhere((c) => c.id == categoryId).title;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .66,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) => ProductCard(product: items[i]),
      ),
    );
  }
}
