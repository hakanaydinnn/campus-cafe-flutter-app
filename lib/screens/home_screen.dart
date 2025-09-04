import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app/themes.dart';
import '../data/sample_data.dart';
import '../widgets/product_card.dart';
import '../widgets/tap_scale.dart';
import '../widgets/stagger_fade_in.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildCategoryImage(String imagePath, {double size = 72}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.category),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shuffled = List.of(products)..shuffle(Random());
    final todaysSuggestions = shuffled.take(4).toList();

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: SvgPicture.asset(
          'assets/images/campus_cafe_logo.svg',
          height: 56,
          colorFilter: ColorFilter.mode(
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            BlendMode.srcIn,
          ),
        ),
        actions: [
          TapScale(
            pressedScale: 0.9,
            duration: const Duration(milliseconds: 80),
            child: IconButton(
              tooltip: 'Favoriler',
              onPressed: () => context.push('/favorites'),
              icon: const Icon(Icons.favorite),
            ),
          ),
          TapScale(
            pressedScale: 0.9,
            duration: const Duration(milliseconds: 80),
            child: IconButton(
              tooltip: 'Tema',
              onPressed: () => context.read<ThemeProvider>().toggle(),
              icon: const Icon(Icons.brightness_6),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // ---- Bugünün önerileri ----
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bugünün önerileri',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 285,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: todaysSuggestions.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = todaysSuggestions[index];
                        return StaggerFadeIn(
                          index: index, // <- ListView.builder'daki index
                          child: TapScale(
                            child: SizedBox(
                              width: 280,
                              child: ProductCard(
                                  product: item, showDescription: false),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // ---- Kategoriler ----
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .82,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: categories.length,
              itemBuilder: (context, i) {
                final c = categories[i];
                return StaggerFadeIn(
                  index: i,
                  child: TapScale(
                    child: Card(
                      elevation: 12,
                      shadowColor: Colors.black.withOpacity(0.25),
                      surfaceTintColor:
                          Colors.transparent, // Material3 tint’i kapatır
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                        onTap: () => context.push('/category/${c.id}'),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24, horizontal: 16),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildCategoryImage(c.image, size: 72),
                                const SizedBox(height: 10),
                                Text(
                                  c.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
