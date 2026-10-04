import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import 'culture_action_target.dart';

class CultureDatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final void Function(DateTime date) onChanged;

  const CultureDatePicker({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  @override
  State<CultureDatePicker> createState() => _CultureDatePickerState();
}

class _CultureDatePickerState extends State<CultureDatePicker> {
  late DateTime _displayedMonth;
  bool _calendarVisible = false;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.selectedDate.year,
      widget.selectedDate.month,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('감상한 날짜', style: AppTextStyles.cardTitle.copyWith(fontSize: 14)),
        const SizedBox(height: 8),
        CultureActionTarget(
          semanticLabel: '감상 날짜 선택',
          borderRadius: BorderRadius.circular(10),
          onActivate: () {
            setState(() {
              _calendarVisible = !_calendarVisible;
              _displayedMonth = DateTime(
                widget.selectedDate.year,
                widget.selectedDate.month,
              );
            });
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.paper,
              border: Border.all(color: AppColors.borderSoft),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 18,
                  color: AppColors.cultureText,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    '${widget.selectedDate.year}.${_twoDigits(widget.selectedDate.month)}.${_twoDigits(widget.selectedDate.day)}',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  _calendarVisible
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ),
        if (_calendarVisible) ...[const SizedBox(height: 9), _buildCalendar()],
      ],
    );
  }

  Widget _buildCalendar() {
    final int firstWeekday = DateTime(
      _displayedMonth.year,
      _displayedMonth.month,
    ).weekday;
    final int daysInMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month + 1,
      0,
    ).day;
    final DateTime today = DateUtils.dateOnly(DateTime.now());
    final bool canAdvance = _displayedMonth.isBefore(
      DateTime(today.year, today.month),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: AppColors.cream,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _monthArrow(
                icon: Icons.chevron_left_rounded,
                label: '이전 달 보기',
                enabled: true,
                onTap: () {
                  setState(() {
                    _displayedMonth = DateTime(
                      _displayedMonth.year,
                      _displayedMonth.month - 1,
                    );
                  });
                },
              ),
              Expanded(
                child: Text(
                  '${_displayedMonth.year}년 ${_displayedMonth.month}월',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                ),
              ),
              _monthArrow(
                icon: Icons.chevron_right_rounded,
                label: '다음 달 보기',
                enabled: canAdvance,
                onTap: () {
                  setState(() {
                    _displayedMonth = DateTime(
                      _displayedMonth.year,
                      _displayedMonth.month + 1,
                    );
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 3),
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
          const SizedBox(height: 4),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 36,
            ),
            itemCount: 42,
            itemBuilder: (BuildContext context, int index) {
              final int day = index - (firstWeekday - 1) + 1;
              if (day < 1 || day > daysInMonth) {
                return const SizedBox.shrink();
              }
              final DateTime date = DateTime(
                _displayedMonth.year,
                _displayedMonth.month,
                day,
              );
              final bool isSelected = DateUtils.isSameDay(
                date,
                widget.selectedDate,
              );
              final bool isFuture = date.isAfter(today);
              final bool isSunday = index % 7 == 6;

              return CultureActionTarget(
                semanticLabel: '${date.year}년 ${date.month}월 ${date.day}일 선택',
                selected: isSelected,
                onActivate: isFuture
                    ? null
                    : () {
                        widget.onChanged(date);
                        setState(() {
                          _calendarVisible = false;
                        });
                      },
                borderRadius: BorderRadius.circular(16),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.coralDeep
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
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
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _monthArrow({
    required IconData icon,
    required String label,
    required bool enabled,
    required void Function() onTap,
  }) {
    return CultureActionTarget(
      semanticLabel: label,
      onActivate: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(
          icon,
          color: enabled ? AppColors.ink : AppColors.disabledText,
          size: 21,
        ),
      ),
    );
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}
