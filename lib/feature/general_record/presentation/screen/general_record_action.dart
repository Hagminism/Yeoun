import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/general_record_photo.dart';
import '../../domain/model/general_record_view_mode.dart';

part 'general_record_action.freezed.dart';

@freezed
sealed class GeneralRecordAction with _$GeneralRecordAction {
  const factory GeneralRecordAction.tapBackButton() = TapBackButton;

  const factory GeneralRecordAction.createRequested() =
      GeneralRecordCreateRequested;

  const factory GeneralRecordAction.editRequested(String id) =
      GeneralRecordEditRequested;

  const factory GeneralRecordAction.editorDismissed() =
      GeneralRecordEditorDismissed;

  const factory GeneralRecordAction.contentChanged(String content) =
      GeneralRecordContentChanged;

  const factory GeneralRecordAction.dateChanged(DateTime date) =
      GeneralRecordDateChanged;

  const factory GeneralRecordAction.calendarVisibilityChanged(bool visible) =
      GeneralRecordCalendarVisibilityChanged;

  const factory GeneralRecordAction.calendarMonthChanged(DateTime month) =
      GeneralRecordCalendarMonthChanged;

  const factory GeneralRecordAction.photoSelectionRequested() =
      GeneralRecordPhotoSelectionRequested;

  const factory GeneralRecordAction.photosAdded(
    List<GeneralRecordPhoto> photos,
  ) = GeneralRecordPhotosAdded;

  const factory GeneralRecordAction.photoRemoved(String id) =
      GeneralRecordPhotoRemoved;

  const factory GeneralRecordAction.viewModeSelected(
    GeneralRecordViewMode mode,
  ) = GeneralRecordViewModeSelected;

  const factory GeneralRecordAction.saveRequested() =
      GeneralRecordSaveRequested;
}
