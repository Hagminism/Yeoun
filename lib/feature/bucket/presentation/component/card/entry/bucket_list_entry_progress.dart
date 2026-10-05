import 'package:flutter/material.dart';

import '../../../../../../ui/app_colors.dart';
import '../../../../../../ui/app_text_styles.dart';

class BucketListEntryProgress extends StatelessWidget {
  final double progress;
  final String label;

  const BucketListEntryProgress({
    super.key,
    required this.progress,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              size: 14,
              color: AppColors.coralDeep,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.coralDeep,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: progress.clamp(0, 1),
            minHeight: 5,
            backgroundColor: AppColors.creamDeep,
            color: AppColors.coral,
          ),
        ),
      ],
    );
  }
}
