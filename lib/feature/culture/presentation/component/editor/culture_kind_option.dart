import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../domain/model/culture_kind.dart';
import '../culture_action_target.dart';

class CultureKindOption extends StatelessWidget {
  final CultureKind kind;
  final bool selected;
  final void Function() onSelected;

  const CultureKindOption({
    super.key,
    required this.kind,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CultureActionTarget(
      semanticLabel: '${kind.label} 선택',
      selected: selected,
      borderRadius: BorderRadius.circular(20),
      onActivate: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 130),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.coralSoft : AppColors.cream,
          border: Border.all(
            color: selected ? AppColors.coral : AppColors.borderSoft,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          kind.label,
          style: AppTextStyles.small.copyWith(
            color: selected ? AppColors.coralDeep : AppColors.bodyText,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
