import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Taqyid typography system
class AppTextStyles {
  AppTextStyles._();

  // --- Latin / UI Text (Nunito Sans) ---
  static TextStyle get displayLarge => GoogleFonts.nunitoSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle get displayMedium => GoogleFonts.nunitoSans(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.25,
      );

  static TextStyle get headlineLarge => GoogleFonts.nunitoSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.3,
      );

  static TextStyle get headlineMedium => GoogleFonts.nunitoSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.35,
      );

  static TextStyle get titleLarge => GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.4,
      );

  static TextStyle get titleMedium => GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get bodyLarge => GoogleFonts.nunitoSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.55,
      );

  static TextStyle get bodySmall => GoogleFonts.nunitoSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get labelLarge => GoogleFonts.nunitoSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      );

  static TextStyle get labelMedium => GoogleFonts.nunitoSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      );

  static TextStyle get labelSmall => GoogleFonts.nunitoSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      );

  // --- Arabic Text (Scheherazade / fallback) ---
  static TextStyle get arabicBody => const TextStyle(
        fontFamily: 'Scheherazade',
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 2.0,
        letterSpacing: 0.5,
      );

  static TextStyle get arabicLarge => const TextStyle(
        fontFamily: 'Scheherazade',
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 2.0,
        letterSpacing: 0.5,
      );

  static TextStyle get arabicSmall => const TextStyle(
        fontFamily: 'Scheherazade',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.8,
        letterSpacing: 0.3,
      );
}
