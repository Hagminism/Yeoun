import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../domain/model/general_record_view_mode.dart';

class GeneralRecordViewToggle extends StatelessWidget {
  static const double _optionWidth = 76;
  static const double _optionHeight = 36;
  static const Duration _animationDuration = Duration(milliseconds: 240);

  final GeneralRecordViewMode selectedMode;
  final void Function(GeneralRecordViewMode) onSelected;

  const GeneralRecordViewToggle({
    super.key,
    required this.selectedMode,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.creamDeep,
        borderRadius: BorderRadius.circular(14),
      ),
      child: SizedBox(
        width: _optionWidth * 2,
        height: _optionHeight,
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: selectedMode == GeneralRecordViewMode.feed
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              duration: _animationDuration,
              curve: Curves.easeInOutCubic,
              child: Container(
                width: _optionWidth,
                height: _optionHeight,
                decoration: BoxDecoration(
                  color: AppColors.paper,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(color: Color(0x1A24211D), blurRadius: 5),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                _buildOption(
                  label: '피드',
                  icon: Icons.view_agenda_outlined,
                  mode: GeneralRecordViewMode.feed,
                ),
                _buildOption(
                  label: '앨범',
                  icon: Icons.grid_view_rounded,
                  mode: GeneralRecordViewMode.album,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String label,
    required IconData icon,
    required GeneralRecordViewMode mode,
  }) {
    final bool selected = mode == selectedMode;

    return Semantics(
      button: true,
      selected: selected,
      label: '$label 보기',
      child: SizedBox(
        width: _optionWidth,
        height: _optionHeight,
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
                  duration: _animationDuration,
                  curve: Curves.easeInOutCubic,
                  builder: (context, color, child) {
                    return Icon(icon, size: 16, color: color);
                  },
                ),
                const SizedBox(width: 5),
                AnimatedDefaultTextStyle(
                  duration: _animationDuration,
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
