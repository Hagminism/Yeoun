import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';

class SettingsToggle extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;

  const SettingsToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      thumbColor: const WidgetStatePropertyAll<Color>(AppColors.surface),
      trackColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        return states.contains(WidgetState.selected)
            ? AppColors.coralDeep
            : AppColors.disabledControl;
      }),
      trackOutlineColor: const WidgetStatePropertyAll<Color>(AppColors.ink),
    );
  }
}
