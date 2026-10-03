import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

import '../../../../../core/domain/model/space/anniversary.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../badge/home_badge.dart';
import '../button/home_action_button.dart';

class AnniversaryCard extends StatelessWidget {
  final Anniversary anniversary;
  final void Function() onCalendar;

  const AnniversaryCard({
    super.key,
    required this.anniversary,
    required this.onCalendar,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      minHeight: 163,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '처음 만난 날',
                    style: AppTextStyles.cardBody.copyWith(
                      color: AppColors.bodyText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const AppAssetIcon(AppAssets.listSmall),
                ],
              ),
              HomeBadge(label: anniversary.startLabel),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'D+${anniversary.daysTogether}',
                        style: AppTextStyles.hero,
                      ),
                      TextSpan(
                        text: '  일째 사랑 중',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.coralDeep,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                HomeActionButton(
                  label: '기념일 캘린더',
                  borderColor: AppColors.borderSoft,
                  trailingAsset: AppAssets.arrow,
                  onPressed: onCalendar,
                  height: 28,
                  radius: 999,
                  textStyle: AppTextStyles.small.copyWith(color: AppColors.ink),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.mutedSurface),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(anniversary.targetLabel, style: AppTextStyles.small),
              Text(
                'D-${anniversary.remainingDays} (${(anniversary.progress * 100).round()}%)',
                style: AppTextStyles.small.copyWith(
                  color: AppColors.coralDeep,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Semantics(
            label: '기념일까지 ${(anniversary.progress * 100).round()}퍼센트',
            child: Container(
              height: 8,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.mutedSurface,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: anniversary.progress.clamp(0, 1),
                  heightFactor: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.coral,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
