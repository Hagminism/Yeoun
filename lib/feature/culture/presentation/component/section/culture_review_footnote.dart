import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';

class CultureReviewFootnote extends StatelessWidget {
  const CultureReviewFootnote({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 14,
          color: AppColors.disabledText,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            '공간 평균은 감상을 등록한 사람들의 평점으로 계산해요.',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
        ),
      ],
    );
  }
}
