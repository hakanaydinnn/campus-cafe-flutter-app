import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/category_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/splash_screen.dart';
import '../data/sample_data.dart';

/// Tek tip animasyonlu sayfa oluşturucu
CustomTransitionPage<T> _animatedPage<T>({required Widget child}) {
  return CustomTransitionPage<T>(
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.03, 0.02), // hafif sağ–aşağıdan gelsin
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) =>
            _animatedPage(child: const SplashScreen()),
      ),
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            _animatedPage(child: const HomeScreen()),
        routes: [
          GoRoute(
            path: 'category/:id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              return _animatedPage(child: CategoryScreen(categoryId: id));
            },
          ),
          GoRoute(
            path: 'favorites',
            pageBuilder: (context, state) =>
                _animatedPage(child: const FavoritesScreen()),
          ),
          GoRoute(
            path: 'product/:id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              final product = products.firstWhere((p) => p.id == id);
              return _animatedPage(child: ProductDetailScreen(product: product));
            },
          ),
        ],
      ),
    ],
  );
}