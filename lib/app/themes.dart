import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggle() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class AppColors {
  static const primary = Color(0xFF0E7C86);
  static const secondary = Color(0xFF6DA5A8);
  static const surface = Color(0xFFF6F7F9);
  static const darkSurface = Color(0xFF0F1216);
}

class AppTheme {
  static ThemeData _base(ColorScheme scheme, bool isDark) {
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
      useMaterial3: true,
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: isDark ? Colors.white : Colors.black87,
        displayColor: isDark ? Colors.white : Colors.black87,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static final light = _base(
    const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    false,
  );

  static final dark = _base(
    const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    true,
  );
}