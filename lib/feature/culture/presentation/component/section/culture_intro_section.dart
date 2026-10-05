import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';

class CultureIntroSection extends StatelessWidget {
  const CultureIntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '좋아한 장면들이 모여\n우리의 취향이 됩니다.',
          style: AppTextStyles.heading.copyWith(height: 1.3, fontSize: 22),
        ),
        const SizedBox(height: 4),
        Text(
          '작품이 남긴 여운을 천천히 모아보세요.',
          style: AppTextStyles.small.copyWith(
            color: AppColors.secondaryText,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
