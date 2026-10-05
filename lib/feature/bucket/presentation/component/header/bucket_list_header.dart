import 'package:flutter/material.dart';

import '../../../../../core/presentation/responsive/app_breakpoints.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import 'action/bucket_list_header_action_button.dart';

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
                  BucketListHeaderActionButton(
                    asset: AppAssets.plus,
                    label: '버킷 추가',
                    onPressed: onAdd,
                  ),
                  const SizedBox(width: 8),
                  BucketListHeaderActionButton(
                    asset: AppAssets.bell3d,
                    label: '알림',
                    onPressed: onNotifications,
                  ),
                  const SizedBox(width: 8),
                  BucketListHeaderActionButton(
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
}
