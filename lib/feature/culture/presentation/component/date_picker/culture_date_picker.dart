import 'package:flutter/material.dart';

import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';
import '../interaction/culture_action_target.dart';
import 'culture_calendar.dart';

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
                const AppAssetIcon(AppAssets.calendar3d, width: 18, height: 18),
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
        if (_calendarVisible) ...[
          const SizedBox(height: 9),
          CultureCalendar(
            displayedMonth: _displayedMonth,
            selectedDate: widget.selectedDate,
            onMonthChanged: (DateTime month) {
              setState(() {
                _displayedMonth = month;
              });
            },
            onDateSelected: (DateTime date) {
              widget.onChanged(date);
              setState(() {
                _calendarVisible = false;
              });
            },
          ),
        ],
      ],
    );
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');
}
