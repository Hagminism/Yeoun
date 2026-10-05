import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';

class GeneralRecordEditorDateButton extends StatelessWidget {
  final DateTime date;
  final bool calendarVisible;
  final void Function() onTap;

  const GeneralRecordEditorDateButton({
    super.key,
    required this.date,
    required this.calendarVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '기록 날짜 선택',
      child: Material(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderSoft),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.coralDeep,
                  size: 20,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    '${date.year}년 ${date.month}월 ${date.day}일',
                    style: AppTextStyles.body.copyWith(color: AppColors.ink),
                  ),
                ),
                Icon(
                  calendarVisible ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
