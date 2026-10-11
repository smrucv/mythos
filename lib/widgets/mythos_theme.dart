import 'package:flutter/material.dart';

class MythosPalette {
  static const background = Color(0xFF10101A);
  static const surface = Color(0xFF1C1C2B);
  static const surfaceRaised = Color(0xFF27263B);
  static const purple = Color(0xFFC0A5FF);
  static const gold = Color(0xFFEECFA0);
  static const muted = Color(0xFFB1ABC4);
}

ThemeData createMythosTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: MythosPalette.purple,
    brightness: Brightness.dark,
    surface: MythosPalette.surface,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: MythosPalette.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: MythosPalette.background,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.w800, height: 1.1),
      titleLarge: TextStyle(fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(height: 1.65),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: MythosPalette.surface,
      prefixIconColor: MythosPalette.muted,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: MythosPalette.purple,
        foregroundColor: MythosPalette.background,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      ),
    ),
  );
}
