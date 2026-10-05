import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';

class CultureWorkSectionHeading extends StatelessWidget {
  final int workCount;
  final int reviewCount;

  const CultureWorkSectionHeading({
    super.key,
    required this.workCount,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OUR SHELF',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.secondaryText,
                  letterSpacing: .9,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 2),
              Text('함께 남긴 작품', style: AppTextStyles.heading),
            ],
          ),
        ),
        Text(
          '작품 $workCount · 감상 $reviewCount',
          style: AppTextStyles.caption.copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }
}
