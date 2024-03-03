import 'package:flutter/material.dart';
import 'package:smart_pay/core/framework/theme/color/app_colors.dart';

class AppTheme {
  final AppColors colors;
  final ThemeMode mode;

  const AppTheme._({
    required this.colors,
    required this.mode,
  });

  factory AppTheme.light() {
    return AppTheme._(
      mode: ThemeMode.light,
      colors: AppColors(
        always111827: const Color(0xFF111827),
        alwaysLight: Colors.white,
        alwaysF9FAFB: const Color(0xFFF9FAFB),
        always0A6375: const Color(0xFF0A6375),
        always2FA2B9: const Color(0xFF2FA2B9),
        alwaysE5E7EB: const Color(0xFFE5E7EB),
        always727272: const Color(0xFF727272),
        alwaysBlack: Colors.black,
        always9CA3AF: const Color(0xFF9CA3AF),
        lightWhiteDarkBlack: Colors.white,
        lightBlackDarkWhite: Colors.black,
        always6B7280: const Color(0xFF6B7280),
      ),
    );
  }

  factory AppTheme.dark() {
    return AppTheme._(
      mode: ThemeMode.dark,
      colors: AppColors(
        always111827: const Color(0xFF111827),
        alwaysLight: Colors.white,
        always2FA2B9: const Color(0xFF2FA2B9),
        alwaysE5E7EB: const Color(0xFFE5E7EB),
        always9CA3AF: const Color(0xFF9CA3AF),
        always0A6375: const Color(0xFF0A6375),
        alwaysF9FAFB: const Color(0xFFF9FAFB),
        always727272: const Color(0xFF727272),
        alwaysBlack: Colors.black,
        lightWhiteDarkBlack: Colors.black,
        lightBlackDarkWhite: Colors.white,
        always6B7280: const Color(0xFF6B7280),
      ),
    );
  }
}
