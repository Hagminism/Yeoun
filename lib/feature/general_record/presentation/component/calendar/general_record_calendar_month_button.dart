import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';

class GeneralRecordCalendarMonthButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function() onTap;

  const GeneralRecordCalendarMonthButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(icon, size: 21, color: AppColors.bodyText),
        ),
      ),
    );
  }
}
