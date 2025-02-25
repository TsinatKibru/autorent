import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppPalette.primaryColor,
      onPrimary: AppPalette.onPrimary,
      secondary: AppPalette.secondaryColor,
      onSecondary: AppPalette.onSecondary,
      surface: AppPalette.surfaceColor,
      onSurface: AppPalette.onSurface,
      error: AppPalette.errorColor,
      onError: AppPalette.onError,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPalette.textPrimary),
      bodyMedium: TextStyle(color: AppPalette.textSecondary),
    ),
    scaffoldBackgroundColor: AppPalette.lightBackgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: AppPalette.inputBorderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: AppPalette.primaryColor.withOpacity(0.3),
            width: 2), // Slightly thicker when focused
      ),
      hintStyle: const TextStyle(color: AppPalette.textSecondary),
      labelStyle: const TextStyle(color: AppPalette.textPrimary),
    ),
    useMaterial3: true,
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppPalette.primaryColor,
      onPrimary: AppPalette.onPrimary,
      secondary: AppPalette.secondaryColor,
      onSecondary: AppPalette.onSecondary,
      surface: AppPalette.surfaceColor,
      onSurface: AppPalette.onSurface,
      error: AppPalette.errorColor,
      onError: AppPalette.onError,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPalette.textOnDark),
      bodyMedium: TextStyle(color: AppPalette.textSecondary),
    ),
    scaffoldBackgroundColor: AppPalette.darkBackgroundColor,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPalette.inputBorderColor, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppPalette.inputBorderColor, width: 2),
      ),
      hintStyle: TextStyle(color: AppPalette.textSecondary),
      labelStyle: TextStyle(color: AppPalette.textOnDark),
    ),
    useMaterial3: true,
  );
}
