import 'package:flutter/material.dart';

import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';

class GeneralRecordEmptyState extends StatelessWidget {
  final void Function() onAdd;

  const GeneralRecordEmptyState({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Image.asset(AppAssets.sparkle3d, width: 64, height: 64),
          const SizedBox(height: 18),
          Text(
            '아직 모인 기억이 없어요',
            style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            '처음으로 남긴 순간이 이곳의 시작이 돼요.',
            textAlign: TextAlign.center,
            style: AppTextStyles.small.copyWith(
              color: AppColors.secondaryText,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 18),
          Material(
            color: AppColors.coralDeep,
            borderRadius: BorderRadius.circular(13),
            child: InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(13),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 12,
                ),
                child: Text(
                  '첫 기록 남기기',
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
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
