import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme.dart';

/// Shared header for auth screens: a small mark, a headline,
/// and a supporting line. Keeps login/register visually aligned.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 24),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(title, style: textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.sm),
        Text(subtitle, style: textTheme.bodyMedium),
      ],
    );
  }
}