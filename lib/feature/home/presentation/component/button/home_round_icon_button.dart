import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

class HomeRoundIconButton extends StatelessWidget {
  final String asset;
  final String label;
  final void Function() onPressed;

  const HomeRoundIconButton({
    super.key,
    required this.asset,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Semantics(
        label: label,
        button: true,
        child: Material(
          color: AppColors.surface,
          shape: CircleBorder(
            side: BorderSide(
              color: AppColors.controlInk.withValues(alpha: 0.1),
            ),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.canvas, offset: Offset(2, 2)),
                ],
              ),
              child: Center(child: AppAssetIcon(asset)),
            ),
          ),
        ),
      ),
    );
  }
}
