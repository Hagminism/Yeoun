import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../domain/model/bucket_list_category.dart';

class BucketListFilterChips extends StatelessWidget {
  final BucketListCategory selectedCategory;
  final void Function(BucketListCategory) onSelected;

  const BucketListFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final category in BucketListCategory.values) ...[
            _filterChip(category, category == selectedCategory, () {
              onSelected(category);
            }),
            if (category != BucketListCategory.values.last)
              const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  Widget _filterChip(
    BucketListCategory category,
    bool selected,
    void Function() onPressed,
  ) {
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
