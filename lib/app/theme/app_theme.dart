import 'package:flutter/material.dart';

class AppTheme {
  static const Color pastelBlue = Color(0xFFE8F0FE);
  static const Color oliveGreen = Color(0xFF556B2F);
  static const Color gold = Color(0xFFD4AF37);

  static const Color darkBackground = Color(0xFF20251D);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: pastelBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: oliveGreen,
      brightness: Brightness.light,
    ).copyWith(
      primary: oliveGreen,
      secondary: gold,
      surface: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: oliveGreen,
      brightness: Brightness.dark,
    ).copyWith(
      secondary: gold,
    ),
  );
}