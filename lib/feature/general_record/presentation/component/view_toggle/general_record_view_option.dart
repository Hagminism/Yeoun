import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../domain/model/general_record_view_mode.dart';

class GeneralRecordViewOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final GeneralRecordViewMode mode;
  final GeneralRecordViewMode selectedMode;
  final double width;
  final double height;
  final Duration animationDuration;
  final void Function(GeneralRecordViewMode) onSelected;

  const GeneralRecordViewOption({
    super.key,
    required this.label,
    required this.icon,
    required this.mode,
    required this.selectedMode,
    required this.width,
    required this.height,
    required this.animationDuration,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool selected = mode == selectedMode;

    return Semantics(
      button: true,
      selected: selected,
      label: '$label 보기',
      child: SizedBox(
        width: width,
        height: height,
        child: InkWell(
          onTap: () => onSelected(mode),
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<Color?>(
                  tween: ColorTween(
                    end: selected
                        ? AppColors.coralDeep
                        : AppColors.secondaryText,
                  ),
                  duration: animationDuration,
                  curve: Curves.easeInOutCubic,
                  builder: (BuildContext context, Color? color, Widget? child) {
                    return Icon(icon, size: 16, color: color);
                  },
                ),
                const SizedBox(width: 5),
                AnimatedDefaultTextStyle(
                  duration: animationDuration,
                  curve: Curves.easeInOutCubic,
                  style: AppTextStyles.caption.copyWith(
                    color: selected ? AppColors.ink : AppColors.secondaryText,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  child: Text(label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
