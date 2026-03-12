import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); // prevent instantiation

  // ===== COLOR SEED =====
  static const Color _seedColor = Colors.indigo;

  // ===== LIGHT THEME =====
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    ),

    scaffoldBackgroundColor: const Color(0xFFF5F7FA),

    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),

    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 3,
    ),

    textTheme: _textTheme(Brightness.light),
  );

  // ===== DARK THEME =====
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),

    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 3,
    ),

    textTheme: _textTheme(Brightness.dark),
  );

  // ===== TYPOGRAPHY =====
  static TextTheme _textTheme(Brightness brightness) {
    final base = brightness == Brightness.light
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: 16),
    );
  }
}
