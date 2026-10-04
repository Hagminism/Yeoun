import 'package:flutter/material.dart';

import '../../../../../core/presentation/responsive/app_breakpoints.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

class BucketListHeader extends StatelessWidget {
  final void Function() onAdd;
  final void Function() onNotifications;
  final void Function() onSettings;

  const BucketListHeader({
    super.key,
    required this.onAdd,
    required this.onNotifications,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final horizontalPadding =
            16 + 16 * AppBreakpoints.desktopProgress(constraints.maxWidth);
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.maxContentWidth + 64,
            ),
            child: Container(
              height: 64,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              color: AppColors.paper,
              child: Row(
                children: [
                  const Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 2),
                          Image(
                            image: AssetImage(AppAssets.wordmarkEn),
                            height: 36,
                            fit: BoxFit.contain,
                            semanticLabel: 'Yeoun',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _headerButton(
                    asset: AppAssets.plus,
                    label: '버킷 추가',
                    onPressed: onAdd,
                  ),
                  const SizedBox(width: 8),
                  _headerButton(
                    asset: AppAssets.bell,
                    label: '알림',
                    onPressed: onNotifications,
                  ),
                  const SizedBox(width: 8),
                  _headerButton(
                    asset: AppAssets.settingsSmall,
                    label: '설정',
                    onPressed: onSettings,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _headerButton({
    required String asset,
    required String label,
    required void Function() onPressed,
  }) {
    return Tooltip(
      message: label,
      child: Semantics(
        label: label,
        button: true,
        child: Material(
          color: AppColors.surface,
          shape: const CircleBorder(
            side: BorderSide(color: AppColors.controlInk),
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
