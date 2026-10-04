import 'package:flutter/material.dart';
import '../../../../../core/domain/model/space/space_widget_category.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';

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
          _categoryButton(label: '전체', category: null),
          for (final category in SpaceWidgetCategory.values) ...[
            const SizedBox(width: 8),
            _categoryButton(label: category.label, category: category),
          ],
        ],
      ),
    );
  }

  Widget _categoryButton({
    required String label,
    required SpaceWidgetCategory? category,
  }) {
    final selected = selectedCategory == category;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onChanged(category);
          },
          borderRadius: BorderRadius.circular(999),
          splashColor: AppColors.coralSoft.withValues(alpha: .4),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            constraints: const BoxConstraints(minHeight: 44),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: selected ? AppColors.ink : AppColors.cream,
              border: Border.all(
                color: selected ? AppColors.ink : AppColors.borderSoft,
              ),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              label,
              style: AppTextStyles.small.copyWith(
                color: selected ? AppColors.surface : AppColors.bodyText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
