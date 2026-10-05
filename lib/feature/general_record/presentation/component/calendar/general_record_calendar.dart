import 'package:flutter/material.dart';

import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import 'general_record_calendar_month_button.dart';

class GeneralRecordCalendar extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime visibleMonth;
  final void Function(DateTime) onMonthChanged;
  final void Function(DateTime) onDateSelected;

  const GeneralRecordCalendar({
    super.key,
    required this.selectedDate,
    required this.visibleMonth,
    required this.onMonthChanged,
    required this.onDateSelected,
  });

  static const List<String> _weekdays = <String>[
    '월',
    '화',
    '수',
    '목',
    '금',
    '토',
    '일',
  ];

  @override
  Widget build(BuildContext context) {
    final firstWeekdayOffset =
        DateTime(visibleMonth.year, visibleMonth.month, 1).weekday - 1;
    final dayCount = DateTime(visibleMonth.year, visibleMonth.month + 1, 0).day;
    final cellCount = ((firstWeekdayOffset + dayCount + 6) ~/ 7) * 7;

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
              GeneralRecordCalendarMonthButton(
                icon: Icons.chevron_left_rounded,
                label: '이전 달',
                onTap: () => onMonthChanged(
                  DateTime(visibleMonth.year, visibleMonth.month - 1),
                ),
              ),
              Expanded(
                child: Text(
                  '${visibleMonth.year}년 ${visibleMonth.month}월',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.cardTitle,
                ),
              ),
              GeneralRecordCalendarMonthButton(
                icon: Icons.chevron_right_rounded,
                label: '다음 달',
                onTap: () => onMonthChanged(
                  DateTime(visibleMonth.year, visibleMonth.month + 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (var index = 0; index < _weekdays.length; index++)
                Expanded(
                  child: Center(
                    child: Text(
                      _weekdays[index],
                      style: AppTextStyles.caption.copyWith(
                        color: index == 6
                            ? AppColors.coralDeep
                            : AppColors.secondaryText,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cellCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              final day = index - firstWeekdayOffset + 1;
              if (day < 1 || day > dayCount) return const SizedBox.shrink();
              final date = DateTime(visibleMonth.year, visibleMonth.month, day);
              final selected = _sameDay(date, selectedDate);
              return Semantics(
                button: true,
                selected: selected,
                label: '$day일 선택',
                child: InkWell(
                  onTap: () => onDateSelected(date),
                  borderRadius: BorderRadius.circular(9),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.coralDeep
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: AppTextStyles.small.copyWith(
                          color: selected ? Colors.white : AppColors.ink,
                          fontWeight: selected
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

  bool _sameDay(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
