import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';

class SettingsThemeDot extends StatelessWidget {
  const SettingsThemeDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: AppColors.coral,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.ink),
      ),
    );
  }
}
