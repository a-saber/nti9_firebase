import 'package:flutter/material.dart';

/// Central design tokens. Every shared widget and screen pulls
/// colors/type/spacing from here so the whole app stays consistent.
class AppColors {
  AppColors._();

  static const background = Color(0xFFF7F8FA); // cool off-white
  static const surface = Color(0xFFFFFFFF);
  static const ink = Color(0xFF14171F); // near-black text
  static const inkMuted = Color(0xFF6B7280); // secondary text
  static const border = Color(0xFFE3E6EB);
  static const accent = Color(0xFF2451B3); // deep cobalt
  static const accentDeep = Color(0xFF17307A);
  static const success = Color(0xFF1F8A5A);
  static const error = Color(0xFFC0392B);
}

class AppRadius {
  AppRadius._();
  static const field = 14.0;
  static const button = 14.0;
  static const card = 22.0;
}

class AppSpacing {
  AppSpacing._();
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.light,
        primary: AppColors.accent,
        error: AppColors.error,
      ),
    );

    final textTheme = base.textTheme
        .apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    )
        .copyWith(
      // Display type carries the personality of the auth screens.
      headlineMedium: const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.5,
        color: AppColors.ink,
      ),
      titleMedium: const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.ink,
      ),
      bodyMedium: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        height: 1.5,
        color: AppColors.inkMuted,
      ),
      bodySmall: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 13,
        height: 1.4,
        color: AppColors.inkMuted,
      ),
      labelLarge: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );

    return base.copyWith(
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.field),
          borderSide: const BorderSide(color: AppColors.error, width: 1.6),
        ),
        labelStyle: const TextStyle(color: AppColors.inkMuted, fontSize: 15),
        floatingLabelStyle: const TextStyle(color: AppColors.accent),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.accent.withOpacity(0.4),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}