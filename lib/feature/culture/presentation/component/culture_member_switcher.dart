import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../domain/model/culture_member.dart';
import 'member/culture_member_button.dart';

class CultureMemberSwitcher extends StatelessWidget {
  final List<CultureMember> members;
  final String selectedMemberId;
  final void Function(String memberId) onSelected;

  const CultureMemberSwitcher({
    super.key,
    required this.members,
    required this.selectedMemberId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          '지금 기록하는 사람',
          style: AppTextStyles.small.copyWith(color: AppColors.secondaryText),
        ),
        for (final CultureMember member in members)
          CultureMemberButton(
            member: member,
            selected: selectedMemberId == member.id,
            onSelected: onSelected,
          ),
      ],
    );
  }
}
