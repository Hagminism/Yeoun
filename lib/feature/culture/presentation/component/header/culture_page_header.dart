import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../screen/culture_action.dart';

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
      height: 64,
      padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
      decoration: const BoxDecoration(color: AppColors.paper),
      child: Row(
        children: [
          Semantics(
            button: true,
            label: '홈으로',
            child: InkWell(
              onTap: () =>
                  onAction(const CultureAction.navigateBackRequested()),
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.bodyText,
                  size: 21,
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              '문화 생활',
              style: AppTextStyles.header.copyWith(fontSize: 18),
            ),
          ),
          if (!isEditing)
            Semantics(
              button: true,
              label: '작품 추가',
              child: Material(
                color: AppColors.coralDeep,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {
                    onAction(const CultureAction.workCreationRequested());
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, color: Colors.white, size: 17),
                        const SizedBox(width: 2),
                        Text(
                          '작품',
                          style: AppTextStyles.caption.copyWith(
                            height: 1.42,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
