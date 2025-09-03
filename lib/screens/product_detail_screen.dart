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
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1.4,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _ImagePlaceholder(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              product.title, 
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),
            Text(product.description, style: Theme.of(context).textTheme.bodyLarge),

            const SizedBox(height: 24),
            Text('Alerjen Bilgileri', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),

            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DataTable(
                  columnSpacing: 20,
                  headingRowHeight: 36,
                  dataRowMinHeight: 40,
                  dataRowMaxHeight: 56,
                  columns: const [
                    DataColumn(label: Text('Alerjen')),
                    DataColumn(label: Text('Durum')),
                  ],
                  rows: [
                    _row(context, 'Gluten', product.allergens.gluten),
                    _row(context, 'Laktoz', product.allergens.lactose),
                    _row(context, 'Kuruyemiş (Tree nuts)', product.allergens.nuts),
                    _row(context, 'Yer fıstığı (Peanut)', product.allergens.peanuts),
                    _row(context, 'Soya', product.allergens.soy),
                    _row(context, 'Yumurta', product.allergens.egg),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              '${product.price.toStringAsFixed(2)} ₺',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }

  DataRow _row(BuildContext context, String name, AllergenStatus status) {
    late final Widget icon;
    late final String text;
    late final Color color;

    switch (status) {
      case AllergenStatus.contains:
        icon = Icon(Icons.cancel, size: 18, color: Theme.of(context).colorScheme.error);
        text = 'İçerir';
        color = Theme.of(context).colorScheme.error;
        break;
      case AllergenStatus.mayContain:
        icon = Icon(Icons.warning, size: 18, color: Theme.of(context).colorScheme.secondary);
        text = 'İz miktarda içerebilir';
        color = Theme.of(context).colorScheme.secondary;
        break;
      case AllergenStatus.none:
        icon = const Icon(Icons.check_circle, size: 18, color: Colors.green);
        text = 'İçermez';
        color = Colors.green;
        break;
    }

    return DataRow(cells: [
      DataCell(Text(name, maxLines: 2, overflow: TextOverflow.ellipsis)),
      DataCell(Row(
        children: [
          icon,
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: color),
            ),
          ),
        ],
      )),
    ]);
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      alignment: Alignment.center,
      child: const Icon(Icons.local_cafe, size: 48),
    );
  }
}