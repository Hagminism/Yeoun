import 'package:flutter/material.dart';

import '../../../../../../core/domain/model/space/space_widget_category.dart';
import 'home_widget_category_filter_button.dart';

class HomeWidgetCategoryFilter extends StatelessWidget {
  final SpaceWidgetCategory? selectedCategory;
  final void Function(SpaceWidgetCategory?) onChanged;

  const HomeWidgetCategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HomeWidgetCategoryFilterButton(
            label: '전체',
            category: null,
            selectedCategory: selectedCategory,
            onChanged: onChanged,
          ),
          for (final category in SpaceWidgetCategory.values) ...[
            const SizedBox(width: 8),
            HomeWidgetCategoryFilterButton(
              label: category.label,
              category: category,
              selectedCategory: selectedCategory,
              onChanged: onChanged,
            ),
          ],
        ],
      ),
    );
  }
}
