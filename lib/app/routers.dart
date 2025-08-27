import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/category_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/splash_screen.dart';
import '../data/sample_data.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'category/:id',
            builder: (context, state) =>
                CategoryScreen(categoryId: state.pathParameters['id']!),
          ),
          GoRoute(
            path: 'favorites',
            builder: (context, state) => const FavoritesScreen(),
          ),
          GoRoute(
            path: 'product/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final product = products.firstWhere((p) => p.id == id);
              return ProductDetailScreen(product: product);
            },
          ),
        ],
      ),
    ],
  );
}
