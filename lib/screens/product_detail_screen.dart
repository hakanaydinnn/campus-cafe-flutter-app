import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Görsel yerine emoji gösterelim (şimdilik)
            Center(
              child: Text(
                product.isIced ? '🧊' : '☕️',
                style: const TextStyle(fontSize: 100),
              ),
            ),
            const SizedBox(height: 24),
            Text(product.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            Text('${product.price.toStringAsFixed(2)} ₺',
                style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}