import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';

class SettingsFooterAction extends StatelessWidget {
  final String label;
  final void Function() onTap;

  const SettingsFooterAction({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondaryText,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        minimumSize: const Size(0, 32),
      ),
      child: Text(label, style: AppTextStyles.caption),
    );
  }
}
