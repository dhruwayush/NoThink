import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Stitch Design Tokens
  static const Color primary = Color(0xFF137FEC);
  static const Color backgroundDark = Color(0xFF101922);
  static const Color surfaceDark = Color(0xFF1C252E);
  static const Color backgroundLight = Color(0xFFF6F7F8); // unused in dark mode but kept for ref
  static const Color textWhite = Colors.white;
  static const Color textSlate300 = Color(0xFFCBD5E1);
  static const Color textSlate400 = Color(0xFF94A3B8);

  static ThemeData get darkTheme {
    final baseTextTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        surface: surfaceDark,
        surfaceContainer: surfaceDark,
        onSurface: textWhite,
        onPrimary: textWhite,
        background: backgroundDark,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
        titleLarge: baseTextTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: textWhite),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: textSlate300),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        // In darkmode design, inputs were explicitly white or surfaceDark depending on screen
        // We stick to surfaceDark for consistency in dark mode.
        fillColor: surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), // rounded-2xl
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: textSlate400),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: textWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // rounded-xl
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      iconTheme: const IconThemeData(color: textSlate400),
    );
  }
}
