import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00BFA5);
  static const Color accentColor = Color(0xFF8C9EFF);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF212121);

  static const TextStyle headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        surface: backgroundColor,
      ),
    );
  }
}
