import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_assets.dart';

import '../../../../../core/presentation/responsive/app_breakpoints.dart';
import '../button/home_round_icon_button.dart';

class HomeHeader extends StatelessWidget {
  final void Function() onNewRecord;
  final void Function() onNotifications;
  final void Function() onSettings;

  const HomeHeader({
    super.key,
    required this.onNewRecord,
    required this.onNotifications,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final padding =
            16 + 16 * AppBreakpoints.desktopProgress(constraints.maxWidth);
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppBreakpoints.maxContentWidth + 64,
            ),
            child: Container(
              height: 64,
              padding: EdgeInsets.symmetric(horizontal: padding),
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
                  HomeRoundIconButton(
                    asset: AppAssets.plus,
                    label: '새 기록 작성',
                    onPressed: onNewRecord,
                  ),
                  const SizedBox(width: 8),
                  HomeRoundIconButton(
                    asset: AppAssets.bell,
                    label: '알림',
                    onPressed: onNotifications,
                  ),
                  const SizedBox(width: 8),
                  HomeRoundIconButton(
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
