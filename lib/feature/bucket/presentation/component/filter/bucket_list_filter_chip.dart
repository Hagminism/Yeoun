import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../domain/model/bucket_list_category.dart';

class BucketListFilterChip extends StatelessWidget {
  final BucketListCategory category;
  final bool selected;
  final void Function() onPressed;

  const BucketListFilterChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.ink : AppColors.surface,
      shape: const StadiumBorder(side: BorderSide(color: AppColors.ink)),
      child: InkWell(
        onTap: onPressed,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          child: Text(
            category.label,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.surface : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}
