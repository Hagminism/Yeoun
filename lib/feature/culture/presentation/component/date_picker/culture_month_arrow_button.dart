import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../culture_action_target.dart';

class CultureMonthArrowButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final void Function() onTap;

  const CultureMonthArrowButton({
    super.key,
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CultureActionTarget(
      semanticLabel: label,
      onActivate: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(
          icon,
          color: enabled ? AppColors.ink : AppColors.disabledText,
          size: 21,
        ),
      ),
    );
  }
}
