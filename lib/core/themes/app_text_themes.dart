import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextThemes {
  static TextTheme frenchTextTheme(ColorScheme colors) {
    final titleStyle = GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,        // gras
      color: colors.onBackground,
    );

    final bodyStyle = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,        // semi-gras
      color: colors.onBackground,
    );

    return TextTheme(
      // Titres
      displayLarge: titleStyle,
      displayMedium: titleStyle,
      displaySmall: titleStyle,
      headlineLarge: titleStyle,
      headlineMedium: titleStyle,
      headlineSmall: titleStyle,
      titleLarge: titleStyle,
      titleMedium: titleStyle,
      titleSmall: titleStyle,

      // Textes
      bodyLarge: bodyStyle,
      bodyMedium: bodyStyle,
      bodySmall: bodyStyle,
      labelLarge: bodyStyle,
      labelMedium: bodyStyle,
      labelSmall: bodyStyle,
    );
  }


  static TextTheme arabicTextTheme(ColorScheme colors) {
    final titleStyle = GoogleFonts.cairo(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: colors.onBackground,
    );

    final bodyStyle = GoogleFonts.cairo(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: colors.onBackground,
    );

    return TextTheme(
      displayLarge: titleStyle,
      displayMedium: titleStyle,
      displaySmall: titleStyle,
      headlineLarge: titleStyle,
      headlineMedium: titleStyle,
      headlineSmall: titleStyle,
      titleLarge: titleStyle,
      titleMedium: titleStyle,
      titleSmall: titleStyle,

      bodyLarge: bodyStyle,
      bodyMedium: bodyStyle,
      bodySmall: bodyStyle,
      labelLarge: bodyStyle,
      labelMedium: bodyStyle,
      labelSmall: bodyStyle,
    );
  }
}
