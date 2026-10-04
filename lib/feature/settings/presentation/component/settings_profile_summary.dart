import 'package:flutter/material.dart';

import '../../../../core/domain/model/space/anniversary.dart';
import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../../ui/presentation/component/app_card_surface.dart';
import 'settings_avatar_stack.dart';
import 'settings_label_badge.dart';

class SettingsProfileSummary extends StatelessWidget {
  final String spaceTitle;
  final Anniversary anniversary;
  final void Function() onEditSpaceTitle;
  final void Function() onEditProfile;

  const SettingsProfileSummary({
    super.key,
    required this.spaceTitle,
    required this.anniversary,
    required this.onEditSpaceTitle,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = anniversary.startLabel.replaceAll('~', '').trim();

    return AppCardSurface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: SettingsLabelBadge(
                  label: 'D+${anniversary.daysTogether}일째 함께',
                  foreground: AppColors.coralDeep,
                  background: AppColors.coralSoft,
                ),
              ),
              const SizedBox(width: 8),
              const Flexible(
                child: SettingsLabelBadge(
                  label: '파트너 연결됨',
                  foreground: AppColors.sageText,
                  background: AppColors.sage,
                ),
              ),
              const Spacer(),
              const SettingsAvatarStack(),
            ],
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: onEditSpaceTitle,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                spaceTitle,
                style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '매일의 작은 빛깔을 함께 엮어가는 우리만의 아틀리에',
            style: AppTextStyles.small.copyWith(color: AppColors.bodyText),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.borderSoft),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  border: Border.all(color: AppColors.controlInk),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'JW',
                  style: AppTextStyles.small.copyWith(
                    color: AppColors.capsuleBadge,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이지우 (내 계정)',
                      style: AppTextStyles.cardBody.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'jiwoo.sketch@atelier.me',
                      style: AppTextStyles.small.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: onEditProfile,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.ink,
                  side: const BorderSide(color: AppColors.ink),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: const Size(0, 34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '수정',
                  style: AppTextStyles.small.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '처음 만난 날 · $startDate (D+${anniversary.daysTogether})',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
