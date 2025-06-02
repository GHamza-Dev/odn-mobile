import 'package:flutter/material.dart';
import 'app_text_themes.dart';

class AppTheme {
  static ThemeData fromLocale(Locale locale) {
    final colorScheme =
    ColorScheme.fromSeed(seedColor: const Color(0xFF0066CC));

    final isArabic = locale.languageCode.toLowerCase().startsWith('ar');

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: isArabic
          ? AppTextThemes.arabicTextTheme(colorScheme)
          : AppTextThemes.frenchTextTheme(colorScheme),
    );
  }
}
