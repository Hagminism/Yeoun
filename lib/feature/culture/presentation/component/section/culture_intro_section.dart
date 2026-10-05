import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';

class CultureIntroSection extends StatelessWidget {
  final String memberName;

  const CultureIntroSection({super.key, required this.memberName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CULTURE ARCHIVE   /   01',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.cultureText,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '좋아한 장면들이 모여\n우리의 취향이 됩니다.',
          style: AppTextStyles.title.copyWith(
            fontSize: 25,
            height: 1.34,
            letterSpacing: -.5,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          memberName.isEmpty
              ? '작품마다 각자의 평점을 남겨보세요.'
              : '$memberName님으로 기록 중 · 작품마다 감상은 한 번씩 남길 수 있어요.',
          style: AppTextStyles.small.copyWith(
            color: AppColors.secondaryText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
