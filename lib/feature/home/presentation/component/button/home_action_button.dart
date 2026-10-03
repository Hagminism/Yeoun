import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

class HomeActionButton extends StatelessWidget {
  final String label;
  final String? asset;
  final String? trailingAsset;
  final void Function() onPressed;
  final Color background;
  final Color borderColor;
  final double horizontalPadding;
  final double assetSpacing;
  final double radius;
  final double height;
  final TextStyle? textStyle;

  const HomeActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.asset,
    this.trailingAsset,
    this.background = AppColors.creamDeep,
    this.borderColor = AppColors.ink,
    this.horizontalPadding = 12,
    this.assetSpacing = 6,
    this.radius = 12,
    this.height = 42,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radius),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 5,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (asset != null) ...[
                  AppAssetIcon(asset!),
                  SizedBox(width: assetSpacing),
                ],
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style:
                        textStyle ??
                        AppTextStyles.cardBody.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                if (trailingAsset != null) ...[
                  SizedBox(width: assetSpacing),
                  AppAssetIcon(trailingAsset!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
