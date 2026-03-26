import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryGreen,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryGreenSurface,
      onPrimaryContainer: AppColors.primaryGreenDark,
      secondary: AppColors.accentGold,
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFF5EDD8),
      onSecondaryContainer: const Color(0xFF5C4400),
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: const Color(0xFF410002),
      surface: AppColors.surfaceLight,
      onSurface: AppColors.onSurfaceLight,
      surfaceContainerHighest: AppColors.surfaceVariantLight,
      onSurfaceVariant: AppColors.onSurfaceVariantLight,
      outline: AppColors.outlineLight,
      outlineVariant: const Color(0xFFEBE6E1),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: const Color(0xFF1E1B18),
      onInverseSurface: const Color(0xFFF5EFE7),
      inversePrimary: const Color(0xFF6FD9A8),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      extensions: const [TaqyidColors.light],
      textTheme: _buildTextTheme(AppColors.onSurfaceLight),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        labelStyle: AppTextStyles.labelMedium,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariantLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.onSurfaceVariantLight,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.outlineLight,
        thickness: 1,
        space: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreen,
          side: const BorderSide(color: AppColors.primaryGreen),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryGreenLight,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryGreenDark,
      onPrimaryContainer: const Color(0xFF9FFFD1),
      secondary: AppColors.accentGoldLight,
      onSecondary: const Color(0xFF3B2800),
      secondaryContainer: const Color(0xFF553C00),
      onSecondaryContainer: const Color(0xFFFFDE87),
      error: const Color(0xFFFFB4AB),
      onError: const Color(0xFF690005),
      errorContainer: const Color(0xFF93000A),
      onErrorContainer: const Color(0xFFFFDAD6),
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      surfaceContainerHighest: AppColors.surfaceVariantDark,
      onSurfaceVariant: AppColors.onSurfaceVariantDark,
      outline: AppColors.outlineDark,
      outlineVariant: const Color(0xFF2A3E33),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: const Color(0xFFEEEAE2),
      onInverseSurface: const Color(0xFF1E1B18),
      inversePrimary: AppColors.primaryGreen,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      extensions: const [TaqyidColors.dark],
      textTheme: _buildTextTheme(AppColors.onSurfaceDark),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.onSurfaceDark,
        elevation: 0,
        scrolledUnderElevation: 2,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleLarge.copyWith(color: AppColors.onSurfaceDark),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.surfaceDark,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        labelStyle: AppTextStyles.labelMedium,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariantDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryGreenLight, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryGreenLight,
        unselectedItemColor: AppColors.onSurfaceVariantDark,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.outlineDark,
        thickness: 1,
        space: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryGreenLight,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreenLight,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryGreenLight,
          side: const BorderSide(color: AppColors.primaryGreenLight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTextStyles.labelLarge,
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(Color baseColor) {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: baseColor),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: baseColor),
      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: baseColor),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: baseColor),
      titleLarge: AppTextStyles.titleLarge.copyWith(color: baseColor),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: baseColor),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: baseColor),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: baseColor),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: baseColor.withValues(alpha: 0.7)),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: baseColor),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: baseColor),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: baseColor.withValues(alpha: 0.7)),
    );
  }
}
