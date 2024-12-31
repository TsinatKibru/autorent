import 'package:flutter/material.dart';

class AppPalette {
  // Primary Colors
  static const Color primaryColor = Color(0xFF32D34B); // Main Green
  static const Color onPrimary = Color(0xFFFFFFFF); // White text on primary

  // Secondary Colors
  static const Color secondaryColor =
      Color(0xff32d34b0d); // Light Green (transparent)
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Background and Surface Colors
  static const Color lightBackgroundColor =
      Color(0xFFFFFFFF); // Light mode background
  static const Color onLightBackground =
      Color(0xFF131313); // Dark text for light background
  static const Color darkBackgroundColor =
      Color(0xFF131313); // Dark mode background
  static const Color onDarkBackground =
      Color(0xFFFFFFFF); // Light text for dark background

  static const Color surfaceColor = Color(0xFFFFFFFF); // Surface color (white)
  static const Color onSurface =
      Color(0xFF131313); // Text color on white surfaces

  // Error Colors
  static const Color errorColor = Color(0xFFB00020); // Red for errors
  static const Color onError =
      Color(0xFFFFFFFF); // White text on error surfaces

  // Text Colors
  static const Color textPrimary =
      Color(0xFF131313); // Primary text for light mode
  static const Color textSecondary =
      Color(0xFFB0B0B0); // Secondary text for light mode
  static const Color textOnDark =
      Color(0xFFFFFFFF); // Text for dark mode backgrounds

  static const Color inputBorderColor =
      Color(0xFF1313131A); // Light transparent border (#1313131A)
}
