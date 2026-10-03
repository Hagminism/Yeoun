import 'package:flutter/material.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/app_assets.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

import '../../../../../core/domain/model/capsule/time_capsule.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../badge/home_badge.dart';
import '../header/home_card_header.dart';

class CapsuleEntryCard extends StatelessWidget {
  final TimeCapsule capsule;
  final void Function() onOpen;

  const CapsuleEntryCard({
    super.key,
    required this.capsule,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      minHeight: 190,
      child: Column(
        children: [
          const HomeCardHeader(
            title: '우리의 타임캡슐',
            capsule: true,
            trailing: HomeBadge(
              label: 'SEALED 봉인 중',
              background: AppColors.capsuleBadge,
              foreground: AppColors.surface,
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: AppColors.cream,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.borderSoft),
            ),
            child: InkWell(
              onTap: onOpen,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                capsule.title,
                                style: AppTextStyles.cardTitle.copyWith(
                                  fontSize: 15,
                                  height: 1.375,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                capsule.authors,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.small,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.apricot,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.ink),
                          ),
                          child: const Center(
                            child: AppAssetIcon(AppAssets.lock),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: AppColors.borderSoft),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        const AppAssetIcon(AppAssets.clock),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            capsule.openingLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.small.copyWith(
                              color: AppColors.cultureText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'D-${capsule.remainingDays}',
                          style: AppTextStyles.cardTitle.copyWith(
                            color: AppColors.cultureText,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
