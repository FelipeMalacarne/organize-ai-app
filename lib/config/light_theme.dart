import 'package:flutter/material.dart';

class AppLightTheme {
  /// COLOR DECLARATION
  static const Color primaryColor = Color.fromARGB(255, 29, 104, 209);
  static const Color secondaryColor = Color(0xFF00BCD4);

  static const Color backgroundColor = Color.fromARGB(255, 228, 228, 228);

  static const Color textColor = Color(0xFF212121);
  static const Color buttonTextColor = Color.fromARGB(255, 226, 226, 226);

  /// STYLES
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: buttonTextColor,
  );

  static const TextStyle inputTextStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  /// DECORATIONS
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: primaryColor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey, width: 1.0),
    ),
    labelStyle: const TextStyle(color: Colors.grey),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  static ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: buttonTextColor,
      minimumSize: const Size(110, 45),
      textStyle: buttonTextStyle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    ),
  );

  /// THEME
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
      ),
      elevatedButtonTheme: elevatedButtonThemeData,
      inputDecorationTheme: inputDecorationTheme,
      textTheme: const TextTheme(
        bodyMedium: inputTextStyle,
      ),
    );
  }
}
