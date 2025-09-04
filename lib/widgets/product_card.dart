import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/favorites_provider.dart';
import '../widgets/tap_scale.dart';
import '../widgets/cupertino_toast.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool showDescription;

  const ProductCard({
    super.key,
    required this.product,
    this.showDescription = true,
  });

  @override
  Widget build(BuildContext context) {
    final favs = context.watch<FavoritesProvider>();
    final isFav = favs.isFavorite(product);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: TapScale(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push('/product/${product.id}'),
          child: SizedBox(
            height: 240,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1.4,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: Colors.black12,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.local_cafe,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          // Favori butonu
                          Positioned(
                            top: 8,
                            right: 8,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOut,
                              decoration: BoxDecoration(
                                color: isFav
                                    ? Colors.red.withOpacity(0.20)
                                    : Colors.black.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 180),
                                transitionBuilder: (child, anim) {
                                  final curved = CurvedAnimation(
                                      parent: anim, curve: Curves.easeOutBack);
                                  return ScaleTransition(
                                      scale: curved, child: child);
                                },
                                child: IconButton(
                                  key: ValueKey<bool>(isFav),
                                  constraints: const BoxConstraints.tightFor(
                                      width: 36, height: 36),
                                  padding: EdgeInsets.zero,
                                  tooltip: isFav
                                      ? 'Favoriden çıkar'
                                      : 'Favorilere ekle',
                                  icon: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFav ? Colors.red : Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    // Yeni durum (toggle sonrası) — mesaj için anında kullan
                                    final willBeFav = !isFav;

                                    favs.toggleFavorite(product);

                                    // iOS tarzı toast
                                    CupertinoToast.show(
                                      context,
                                      message: willBeFav
                                          ? 'Favorilere eklendi'
                                          : 'Favoriden çıkarıldı',
                                      icon: willBeFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (showDescription) ...[
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  const Spacer(),
                  Text(
                    '${product.price.toStringAsFixed(0)} ₺',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
