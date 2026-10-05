import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../interaction/culture_action_target.dart';
import 'culture_month_arrow_button.dart';

class CultureCalendar extends StatelessWidget {
  final DateTime displayedMonth;
  final DateTime selectedDate;
  final void Function(DateTime month) onMonthChanged;
  final void Function(DateTime date) onDateSelected;

  const CultureCalendar({
    super.key,
    required this.displayedMonth,
    required this.selectedDate,
    required this.onMonthChanged,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final int firstWeekday = DateTime(
      displayedMonth.year,
      displayedMonth.month,
    ).weekday;
    final int daysInMonth = DateTime(
      displayedMonth.year,
      displayedMonth.month + 1,
      0,
    ).day;
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final bool canAdvance = displayedMonth.isBefore(
      DateTime(today.year, today.month),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(13, 12, 13, 13),
      decoration: BoxDecoration(
        color: AppColors.paper,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CultureMonthArrowButton(
                icon: Icons.chevron_left_rounded,
                label: '이전 달 보기',
                enabled: true,
                onTap: () => onMonthChanged(
                  DateTime(displayedMonth.year, displayedMonth.month - 1),
                ),
              ),
              Expanded(
                child: Text(
                  '${displayedMonth.year}년 ${displayedMonth.month}월',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                ),
              ),
              CultureMonthArrowButton(
                icon: Icons.chevron_right_rounded,
                label: '다음 달 보기',
                enabled: canAdvance,
                onTap: () => onMonthChanged(
                  DateTime(displayedMonth.year, displayedMonth.month + 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <String>['월', '화', '수', '목', '금', '토', '일']
                .map(
                  (String day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: AppTextStyles.caption.copyWith(
                          color: day == '일'
                              ? AppColors.coralDeep
                              : AppColors.secondaryText,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 5),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              mainAxisExtent: 36,
            ),
            itemCount: ((firstWeekday - 1 + daysInMonth + 6) ~/ 7) * 7,
            itemBuilder: (BuildContext context, int index) {
              final int day = index - (firstWeekday - 1) + 1;
              if (day < 1 || day > daysInMonth) {
                return const SizedBox.shrink();
              }
              final DateTime date = DateTime(
                displayedMonth.year,
                displayedMonth.month,
                day,
              );
              final bool isSelected = DateUtils.isSameDay(date, selectedDate);
              final bool isFuture = date.isAfter(today);
              final bool isSunday = index % 7 == 6;

              return CultureActionTarget(
                semanticLabel: '${date.year}년 ${date.month}월 ${date.day}일 선택',
                selected: isSelected,
                onActivate: isFuture ? null : () => onDateSelected(date),
                borderRadius: BorderRadius.circular(9),
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.coralDeep
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: AppTextStyles.small.copyWith(
                          color: isSelected
                              ? AppColors.surface
                              : isFuture
                              ? AppColors.disabledText
                              : isSunday
                              ? AppColors.coralDeep
                              : AppColors.ink,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
