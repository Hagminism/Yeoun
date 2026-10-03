import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';

class HomeBadge extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;

  const HomeBadge({
    super.key,
    required this.label,
    this.background = AppColors.mutedSurface,
    this.foreground = AppColors.bodyText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTextStyles.badge.copyWith(color: foreground),
      ),
    );
  }
}
