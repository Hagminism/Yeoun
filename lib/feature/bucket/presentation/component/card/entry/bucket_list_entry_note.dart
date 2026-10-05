import 'package:flutter/material.dart';

import '../../../../../../ui/app_colors.dart';
import '../../../../../../ui/app_text_styles.dart';

class BucketListEntryNote extends StatelessWidget {
  final String note;
  final String? icon;

  const BucketListEntryNote({
    super.key,
    required this.note,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.cream,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Text(icon!, style: AppTextStyles.cardBody),
            const SizedBox(width: 7),
          ],
          Expanded(
            child: Text(
              note,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.small.copyWith(color: AppColors.bodyText),
            ),
          ),
        ],
      ),
    );
  }
}
