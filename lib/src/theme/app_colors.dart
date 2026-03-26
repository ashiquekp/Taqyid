import 'package:flutter/material.dart';

/// Premium Taqyid color palette based on the primary green #0B5E3C
class AppColors {
  AppColors._();

  // --- Primary Brand Colors ---
  static const Color primaryGreen = Color(0xFF0B5E3C);
  static const Color primaryGreenLight = Color(0xFF0D7A4E);
  static const Color primaryGreenDark = Color(0xFF084530);
  static const Color primaryGreenSurface = Color(0xFFE8F5EE);

  // --- Accent / Secondary ---
  static const Color accentGold = Color(0xFFB8973A);
  static const Color accentGoldLight = Color(0xFFD4AF55);

  // --- Neutral Light ---
  static const Color backgroundLight = Color(0xFFF8F6F2);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceVariantLight = Color(0xFFF0EDE8);
  static const Color onBackgroundLight = Color(0xFF1A1A1A);
  static const Color onSurfaceLight = Color(0xFF2C2C2C);
  static const Color onSurfaceVariantLight = Color(0xFF6B6B6B);
  static const Color outlineLight = Color(0xFFD8D3CC);

  // --- Neutral Dark ---
  static const Color backgroundDark = Color(0xFF0F1A14);
  static const Color surfaceDark = Color(0xFF1A2E22);
  static const Color surfaceVariantDark = Color(0xFF243D2E);
  static const Color onBackgroundDark = Color(0xFFEEEAE2);
  static const Color onSurfaceDark = Color(0xFFD9D4CB);
  static const Color onSurfaceVariantDark = Color(0xFF9FA89E);
  static const Color outlineDark = Color(0xFF3A4F42);

  // --- Semantic Colors ---
  static const Color sahih = Color(0xFF2E7D32);
  static const Color hasan = Color(0xFF1565C0);
  static const Color daif = Color(0xFFE65100);
  static const Color mawdu = Color(0xFFB71C1C);
  static const Color unknown = Color(0xFF546E7A);

  // --- Utility ---
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color success = Color(0xFF388E3C);
  static const Color bookmark = Color(0xFFB8973A);
}

/// ThemeExtension for custom Taqyid brand tokens
class TaqyidColors extends ThemeExtension<TaqyidColors> {
  const TaqyidColors({
    required this.primaryGreen,
    required this.primaryGreenSurface,
    required this.accentGold,
    required this.sahih,
    required this.hasan,
    required this.daif,
    required this.mawdu,
    required this.bookmark,
    required this.cachedIndicator,
    required this.arabicTextColor,
  });

  final Color primaryGreen;
  final Color primaryGreenSurface;
  final Color accentGold;
  final Color sahih;
  final Color hasan;
  final Color daif;
  final Color mawdu;
  final Color bookmark;
  final Color cachedIndicator;
  final Color arabicTextColor;

  static const TaqyidColors light = TaqyidColors(
    primaryGreen: AppColors.primaryGreen,
    primaryGreenSurface: AppColors.primaryGreenSurface,
    accentGold: AppColors.accentGold,
    sahih: AppColors.sahih,
    hasan: AppColors.hasan,
    daif: AppColors.daif,
    mawdu: AppColors.mawdu,
    bookmark: AppColors.bookmark,
    cachedIndicator: Color(0xFF5C8A6A),
    arabicTextColor: Color(0xFF1A2E22),
  );

  static const TaqyidColors dark = TaqyidColors(
    primaryGreen: AppColors.primaryGreenLight,
    primaryGreenSurface: Color(0xFF1A3329),
    accentGold: AppColors.accentGoldLight,
    sahih: Color(0xFF66BB6A),
    hasan: Color(0xFF42A5F5),
    daif: Color(0xFFFF8A65),
    mawdu: Color(0xFFEF5350),
    bookmark: AppColors.accentGoldLight,
    cachedIndicator: Color(0xFF6AAF7F),
    arabicTextColor: Color(0xFFD9D4CB),
  );

  @override
  TaqyidColors copyWith({
    Color? primaryGreen,
    Color? primaryGreenSurface,
    Color? accentGold,
    Color? sahih,
    Color? hasan,
    Color? daif,
    Color? mawdu,
    Color? bookmark,
    Color? cachedIndicator,
    Color? arabicTextColor,
  }) {
    return TaqyidColors(
      primaryGreen: primaryGreen ?? this.primaryGreen,
      primaryGreenSurface: primaryGreenSurface ?? this.primaryGreenSurface,
      accentGold: accentGold ?? this.accentGold,
      sahih: sahih ?? this.sahih,
      hasan: hasan ?? this.hasan,
      daif: daif ?? this.daif,
      mawdu: mawdu ?? this.mawdu,
      bookmark: bookmark ?? this.bookmark,
      cachedIndicator: cachedIndicator ?? this.cachedIndicator,
      arabicTextColor: arabicTextColor ?? this.arabicTextColor,
    );
  }

  @override
  TaqyidColors lerp(TaqyidColors? other, double t) {
    if (other is! TaqyidColors) return this;
    return TaqyidColors(
      primaryGreen: Color.lerp(primaryGreen, other.primaryGreen, t)!,
      primaryGreenSurface: Color.lerp(primaryGreenSurface, other.primaryGreenSurface, t)!,
      accentGold: Color.lerp(accentGold, other.accentGold, t)!,
      sahih: Color.lerp(sahih, other.sahih, t)!,
      hasan: Color.lerp(hasan, other.hasan, t)!,
      daif: Color.lerp(daif, other.daif, t)!,
      mawdu: Color.lerp(mawdu, other.mawdu, t)!,
      bookmark: Color.lerp(bookmark, other.bookmark, t)!,
      cachedIndicator: Color.lerp(cachedIndicator, other.cachedIndicator, t)!,
      arabicTextColor: Color.lerp(arabicTextColor, other.arabicTextColor, t)!,
    );
  }
}
