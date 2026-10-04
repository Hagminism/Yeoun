import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

import '../../../../../ui/presentation/component/app_card_surface.dart';

class PartnerSyncBanner extends StatelessWidget {
  final void Function() onDismiss;

  const PartnerSyncBanner({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      offset: 4,
      minHeight: 70,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Image.asset(AppAssets.bucketList3d, width: 40, height: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '지우 님과 함께 기록 중',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  '모든 일상과 버킷이 실시간으로 동기화돼요',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            tooltip: '연결 배너 닫기',
            onPressed: onDismiss,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 24, minHeight: 28),
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const AppAssetIcon(AppAssets.close),
          ),
        ],
      ),
    );
  }
}
