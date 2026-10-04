import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../screen/culture_action.dart';
import 'culture_action_target.dart';

class CulturePageHeader extends StatelessWidget {
  final void Function(CultureAction action) onAction;
  final bool isEditing;

  const CulturePageHeader({
    super.key,
    required this.onAction,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 68),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.paper,
        border: Border(bottom: BorderSide(color: AppColors.creamDeep)),
      ),
      child: Row(
        children: [
          CultureActionTarget(
            semanticLabel: '홈으로 돌아가기',
            borderRadius: BorderRadius.circular(13),
            onActivate: () =>
                onAction(const CultureAction.navigateBackRequested()),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.cream,
                border: Border.all(color: AppColors.borderSoft),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.ink,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CULTURE NOTES',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.cultureText,
                    letterSpacing: 1.1,
                    fontSize: 9,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '문화 기록장',
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 17),
                ),
              ],
            ),
          ),
          if (!isEditing)
            CultureActionTarget(
              semanticLabel: '작품 추가',
              borderRadius: BorderRadius.circular(13),
              onActivate: () =>
                  onAction(const CultureAction.workCreationRequested()),
              child: Container(
                constraints: const BoxConstraints(minHeight: 42),
                padding: const EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                  color: AppColors.coralDeep,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add_rounded,
                      color: AppColors.surface,
                      size: 19,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '작품 추가',
                      style: AppTextStyles.small.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
