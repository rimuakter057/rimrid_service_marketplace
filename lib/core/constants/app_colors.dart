import 'package:flutter/material.dart';

/// Centralized color palette for the app.
/// Primary brand color is a deep, premium dark red on a light,
/// off-white surface — see README design notes.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF8B0000);
  static const Color primaryDark = Color(0xFF5E0000);
  static const Color primaryLight = Color(0xFFB22222);
  static const Color primarySurface = Color(0xFFFBEAEA);

  // Neutral surfaces
  static const Color background = Color(0xFFFAF8F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF4F1EE);
  static const Color border = Color(0xFFEDE8E4);
  static const Color divider = Color(0xFFEFEAE6);

  // Text
  static const Color textPrimary = Color(0xFF1B1414);
  static const Color textSecondary = Color(0xFF6F6462);
  static const Color textHint = Color(0xFFA69C99);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Semantic
  static const Color success = Color(0xFF2E7D45);
  static const Color successSurface = Color(0xFFE7F5EA);
  static const Color warning = Color(0xFFC98A1D);
  static const Color warningSurface = Color(0xFFFBF0DD);
  static const Color error = Color(0xFFC62828);
  static const Color errorSurface = Color(0xFFFBEAEA);
  static const Color info = Color(0xFF2B6CB0);
  static const Color infoSurface = Color(0xFFE8F0FA);

  // Extras
  static const Color star = Color(0xFFF5A623);
  static const Color online = Color(0xFF34C759);
  static const Color shadow = Color(0x1A1B1414);

  static const List<Color> primaryGradient = [primary, primaryLight];

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primary, primaryLight],
  );

  static Color category(int index) {
    const palette = [
      Color(0xFF8B0000),
      Color(0xFF2B6CB0),
      Color(0xFF2E7D45),
      Color(0xFFC98A1D),
      Color(0xFF6B4EA0),
      Color(0xFF0F766E),
      Color(0xFFB2454A),
      Color(0xFF8A5A2B),
    ];
    return palette[index % palette.length];
  }
}
