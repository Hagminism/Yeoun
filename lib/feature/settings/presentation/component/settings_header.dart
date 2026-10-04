import 'package:flutter/material.dart';

import '../../../../ui/app_assets.dart';
import '../../../../ui/app_colors.dart';
import '../../../home/presentation/component/button/home_round_icon_button.dart';

class SettingsHeader extends StatelessWidget {
  final void Function() onFeatureRequest;
  final void Function() onNotifications;
  final void Function() onSettings;

  const SettingsHeader({
    super.key,
    required this.onFeatureRequest,
    required this.onNotifications,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: AppColors.paper,
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
            label: '기능 요청하기',
            onPressed: onFeatureRequest,
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
    );
  }
}
