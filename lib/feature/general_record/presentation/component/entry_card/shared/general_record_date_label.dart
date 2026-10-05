import 'package:flutter/material.dart';

import '../../../../../../ui/app_colors.dart';
import '../../../../../../ui/app_text_styles.dart';

class GeneralRecordDateLabel extends StatelessWidget {
  final DateTime date;

  const GeneralRecordDateLabel({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              size: 13,
              color: AppColors.coral,
            ),
            const SizedBox(width: 6),
            Text(
              '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}',
              style: AppTextStyles.caption,
            ),
          ],
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
