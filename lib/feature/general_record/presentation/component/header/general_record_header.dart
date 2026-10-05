import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../screen/general_record_action.dart';
import '../../screen/general_record_state.dart';

class GeneralRecordHeader extends StatelessWidget {
  final GeneralRecordState state;
  final void Function(GeneralRecordAction) onAction;

  const GeneralRecordHeader({
    super.key,
    required this.state,
    required this.onAction,
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
            label: state.editorOpen ? '작성 취소' : '홈으로',
            child: InkWell(
              onTap: state.editorOpen
                  ? () => onAction(const GeneralRecordAction.editorDismissed())
                  : () => onAction(const GeneralRecordAction.tapBackButton()),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(8),
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
              state.editorOpen
                  ? state.editingId == null
                        ? '새 기록'
                        : '기록 수정'
                  : '일기장',
              style: AppTextStyles.header.copyWith(fontSize: 18),
            ),
          ),
          if (!state.editorOpen)
            Semantics(
              button: true,
              label: '기록 추가',
              child: Material(
                color: AppColors.coralDeep,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () {
                    onAction(const GeneralRecordAction.createRequested());
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
                          '기록',
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
