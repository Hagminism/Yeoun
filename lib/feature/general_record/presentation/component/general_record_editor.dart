import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../screen/general_record_action.dart';
import '../screen/general_record_state.dart';
import 'general_record_calendar.dart';
import 'general_record_photo_gallery.dart';
import 'editor/general_record_editor_date_button.dart';

class GeneralRecordEditor extends StatelessWidget {
  final GeneralRecordState state;
  final void Function(GeneralRecordAction) onAction;

  const GeneralRecordEditor({
    super.key,
    required this.state,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final date = state.draftDate ?? DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '오늘 마음에 남은 순간을\n천천히 적어보세요.',
          style: AppTextStyles.heading.copyWith(height: 1.3, fontSize: 22),
        ),
        const SizedBox(height: 6),
        Text(
          '제목 없이 글과 사진으로 기억을 남길 수 있어요.',
          style: AppTextStyles.small.copyWith(
            color: AppColors.secondaryText,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 22),
        TextFormField(
          key: ValueKey<int>(state.editorSessionId),
          initialValue: state.draftContent,
          onChanged: (String content) {
            onAction(GeneralRecordAction.contentChanged(content));
          },
          maxLength: 1000,
          minLines: 6,
          maxLines: 12,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          style: AppTextStyles.body.copyWith(
            color: AppColors.ink,
            height: 1.65,
          ),
          decoration: InputDecoration(
            hintText: '기억하고 싶은 장면이나 마음을 적어주세요.',
            hintStyle: AppTextStyles.body.copyWith(
              color: AppColors.disabledText,
              height: 1.65,
            ),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.borderSoft),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.borderSoft),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.coralDeep,
                width: 1.4,
              ),
            ),
            counterStyle: AppTextStyles.caption,
            errorText: state.validationMessage,
          ),
        ),
        const SizedBox(height: 15),
        Text('기록한 날짜', style: AppTextStyles.cardTitle),
        const SizedBox(height: 8),
        GeneralRecordEditorDateButton(
          date: date,
          calendarVisible: state.calendarVisible,
          onTap: () {
            onAction(
              GeneralRecordAction.calendarVisibilityChanged(
                !state.calendarVisible,
              ),
            );
          },
        ),
        if (state.calendarVisible && state.calendarMonth != null) ...[
          const SizedBox(height: 10),
          GeneralRecordCalendar(
            selectedDate: date,
            visibleMonth: state.calendarMonth!,
            onMonthChanged: (DateTime month) {
              onAction(GeneralRecordAction.calendarMonthChanged(month));
            },
            onDateSelected: (DateTime selectedDate) {
              onAction(GeneralRecordAction.dateChanged(selectedDate));
            },
          ),
        ],
        const SizedBox(height: 18),
        GeneralRecordPhotoGallery(
          photos: state.draftPhotos,
          selectingPhotos: state.selectingPhotos,
          allowAdd: state.draftPhotos.length < 5,
          onAdd: () {
            onAction(const GeneralRecordAction.photoSelectionRequested());
          },
          onRemove: (String id) {
            onAction(GeneralRecordAction.photoRemoved(id));
          },
        ),
        const SizedBox(height: 24),
        Semantics(
          button: true,
          label: '기록 저장',
          child: Material(
            color: AppColors.coralDeep,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: () {
                onAction(const GeneralRecordAction.saveRequested());
              },
              borderRadius: BorderRadius.circular(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  state.editingId == null ? '기억 남기기' : '수정 완료',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
