import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'app/themes.dart';
import 'app/routers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const CafeApp(),
    ),
  );
}

class CafeApp extends StatelessWidget {
  const CafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final router = createRouter();

    return AnimatedTheme(
      data: theme.isDarkMode ? AppTheme.dark : AppTheme.light,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Campus Cafe',
        themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: router,
      ),
    );
  }
}