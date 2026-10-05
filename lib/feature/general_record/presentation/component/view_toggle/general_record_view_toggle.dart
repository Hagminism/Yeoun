import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../domain/model/general_record_view_mode.dart';
import 'general_record_view_option.dart';

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
                GeneralRecordViewOption(
                  label: '피드',
                  icon: Icons.view_agenda_outlined,
                  mode: GeneralRecordViewMode.feed,
                  selectedMode: selectedMode,
                  width: _optionWidth,
                  height: _optionHeight,
                  animationDuration: _animationDuration,
                  onSelected: onSelected,
                ),
                GeneralRecordViewOption(
                  label: '앨범',
                  icon: Icons.grid_view_rounded,
                  mode: GeneralRecordViewMode.album,
                  selectedMode: selectedMode,
                  width: _optionWidth,
                  height: _optionHeight,
                  animationDuration: _animationDuration,
                  onSelected: onSelected,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
