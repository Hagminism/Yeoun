import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';

class HomeWidgetToggle extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;
  final String label;

  const HomeWidgetToggle({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      toggled: value,
      child: SizedBox(
        width: 48,
        height: 44,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onChanged(!value);
              },
              customBorder: const StadiumBorder(),
              splashColor: AppColors.coralSoft.withValues(alpha: .45),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 46,
                height: 28,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: value ? AppColors.coral : AppColors.disabledControl,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 180),
                  alignment: value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
