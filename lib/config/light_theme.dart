import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

class AppLightTheme {
  static Flavor flavor = catppuccin.latte;

  /// COLOR DECLARATION
  static Color primaryColor = flavor.mauve;
  static Color secondaryColor = flavor.lavender;

  static Color backgroundColor = flavor.mantle;
  static Color highestBackgroundColor = flavor.surface0;
  static Color lowestBackgroundColor = flavor.crust;

  static Color textColor = flavor.text;
  static Color buttonTextColor = flavor.crust;

  static Color textFieldContourColor = flavor.surface2;

  static Color errorColor = flavor.red;

  /// STYLES
  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: buttonTextColor,
  );

  static TextStyle inputTextStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  /// DECORATIONS
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: lowestBackgroundColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: primaryColor, width: 2.0),
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
        surfaceContainerHighest: highestBackgroundColor,
        surfaceContainerLowest: lowestBackgroundColor,
        error: errorColor,
      ),
      elevatedButtonTheme: elevatedButtonThemeData,
      inputDecorationTheme: inputDecorationTheme,
      textTheme: TextTheme(
        bodyMedium: inputTextStyle,
      ),
    );
  }
}
