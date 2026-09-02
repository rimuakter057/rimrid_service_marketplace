import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Centralized typography. Poppins for display/headline weight, Inter for
/// body copy — keeps the UI feeling modern without mixing more than two
/// families.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _poppins({
    required double size,
    required FontWeight weight,
    Color color = AppColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.poppins(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle _inter({
    required double size,
    required FontWeight weight,
    Color color = AppColors.textPrimary,
    double? height,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );

  static TextStyle h1 = _poppins(size: 30, weight: FontWeight.w700, height: 1.2);
  static TextStyle h2 = _poppins(size: 24, weight: FontWeight.w700, height: 1.25);
  static TextStyle h3 = _poppins(size: 20, weight: FontWeight.w600, height: 1.3);
  static TextStyle h4 = _poppins(size: 17, weight: FontWeight.w600, height: 1.3);

  static TextStyle bodyLarge = _inter(size: 16, weight: FontWeight.w400, height: 1.45);
  static TextStyle bodyMedium = _inter(size: 14, weight: FontWeight.w400, height: 1.4);
  static TextStyle bodySmall = _inter(size: 12, weight: FontWeight.w400, height: 1.35);

  static TextStyle labelLarge = _inter(size: 15, weight: FontWeight.w600);
  static TextStyle labelMedium = _inter(size: 13, weight: FontWeight.w600);
  static TextStyle labelSmall = _inter(size: 11, weight: FontWeight.w600);

  static TextStyle button = _poppins(size: 15, weight: FontWeight.w600, color: AppColors.textOnPrimary);

  static TextStyle caption = _inter(size: 12, weight: FontWeight.w400, color: AppColors.textSecondary);

  static TextStyle price = _poppins(size: 18, weight: FontWeight.w700, color: AppColors.primary);
}
