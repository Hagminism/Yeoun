import 'package:flutter/material.dart';

import '../../../domain/model/bucket_list_category.dart';
import 'bucket_list_filter_chip.dart';

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
            BucketListFilterChip(
              category: category,
              selected: category == selectedCategory,
              onPressed: () => onSelected(category),
            ),
            if (category != BucketListCategory.values.last)
              const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
