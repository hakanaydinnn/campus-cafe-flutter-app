import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app/themes.dart';
import '../data/sample_data.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Cafe'),
        actions: [
          IconButton(
            tooltip: 'Favoriler',
            onPressed: () => context.push('/favorites'),
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            tooltip: 'Tema',
            onPressed: () => context.read<ThemeProvider>().toggle(),
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
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
                    height: 210,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = products[index];
                        return SizedBox(
                          width: 280,
                          child: ProductCard(product: item),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
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
                return InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () => context.push('/category/${c.id}'),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary.withAlpha(26),
                          Theme.of(context).colorScheme.secondary.withAlpha(20),
                        ],
                        begin: Alignment.topLeft, end: Alignment.bottomRight
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(c.emoji, style: const TextStyle(fontSize: 42)),
                          const SizedBox(height: 8),
                          Text(c.title, style: Theme.of(context).textTheme.titleMedium),
                        ],
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
