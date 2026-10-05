import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../domain/model/culture_member.dart';
import '../interaction/culture_action_target.dart';

class CultureMemberButton extends StatelessWidget {
  final CultureMember member;
  final bool selected;
  final void Function(String memberId) onSelected;

  const CultureMemberButton({
    super.key,
    required this.member,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CultureActionTarget(
      semanticLabel: '${member.name} 선택',
      selected: selected,
      borderRadius: BorderRadius.circular(22),
      onActivate: () => onSelected(member.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        constraints: const BoxConstraints(minHeight: 38),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.ink : AppColors.surface,
          border: Border.all(
            color: selected ? AppColors.ink : AppColors.borderSoft,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.coralSoft : AppColors.cream,
                shape: BoxShape.circle,
              ),
              child: Text(
                member.initials,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.coralDeep,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              member.name,
              style: AppTextStyles.small.copyWith(
                color: selected ? AppColors.surface : AppColors.ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
