import 'package:flutter/material.dart';

import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

class CultureEmptyWorkBoard extends StatelessWidget {
  const CultureEmptyWorkBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          const AppAssetIcon(AppAssets.movieProjector3d, width: 64, height: 64),
          const SizedBox(height: 18),
          Text(
            '아직 기록한 작품이 없어요',
            style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            '첫 작품과 감상을 남겨 취향의 기록을 시작해 보세요.',
            textAlign: TextAlign.center,
            style: AppTextStyles.small.copyWith(
              color: AppColors.secondaryText,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
