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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '마음에 남은 작품',
            style: AppTextStyles.heading.copyWith(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            '작품 $workCount',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.bodyText,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
