import 'package:flutter/material.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import 'home_action_button.dart';

class WidgetEditButton extends StatelessWidget {
  final void Function() onPressed;

  const WidgetEditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(color: AppColors.canvas, offset: Offset(4, 4)),
          ],
        ),
        child: HomeActionButton(
          label: '위젯 추가 및 순서 편집',
          asset: AppAssets.sliders,
          background: AppColors.surface,
          radius: 999,
          horizontalPadding: 21,
          assetSpacing: 8,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
