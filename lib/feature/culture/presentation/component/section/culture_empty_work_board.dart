import 'package:flutter/material.dart';

import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

class CultureEmptyWorkBoard extends StatelessWidget {
  const CultureEmptyWorkBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
      decoration: BoxDecoration(
        color: AppColors.cream,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const AppAssetIcon(AppAssets.movieProjector3d, width: 34, height: 34),
          const SizedBox(height: 9),
          Text('첫 작품을 기록해 볼까요?', style: AppTextStyles.cardTitle),
          const SizedBox(height: 4),
          Text(
            '영화부터 음악까지, 오래 간직하고 싶은 감상을 모아보세요.',
            textAlign: TextAlign.center,
            style: AppTextStyles.small.copyWith(color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }
}
