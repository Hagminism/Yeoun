import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';

class BucketListSummaryCard extends StatelessWidget {
  final int activeCount;
  final int completedCount;

  const BucketListSummaryCard({
    super.key,
    required this.activeCount,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.coralSoft,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('✧', style: TextStyle(fontSize: 21, height: 1)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('함께 이루어갈 이야기', style: AppTextStyles.cardTitle),
                const SizedBox(height: 1),
                Text(
                  '적어두면 전부 현실이 될 거예요',
                  style: AppTextStyles.small.copyWith(
                    color: AppColors.bodyText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.cream,
              border: Border.all(color: AppColors.borderSoft),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '진행 $activeCount · 완료 $completedCount',
              style: AppTextStyles.caption.copyWith(color: AppColors.bodyText),
            ),
          ),
        ],
      ),
    );
  }
}
