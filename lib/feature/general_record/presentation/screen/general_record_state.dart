import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/general_record.dart';
import '../../domain/model/general_record_photo.dart';
import '../../domain/model/general_record_view_mode.dart';

part 'general_record_state.freezed.dart';

@freezed
abstract class GeneralRecordState with _$GeneralRecordState {
  const factory GeneralRecordState({
    @Default(<GeneralRecord>[]) List<GeneralRecord> entries,
    @Default(GeneralRecordViewMode.feed) GeneralRecordViewMode viewMode,
    @Default(false) bool editorOpen,
    @Default(0) int editorSessionId,
    String? editingId,
    @Default('') String draftContent,
    DateTime? draftDate,
    DateTime? calendarMonth,
    @Default(false) bool calendarVisible,
    @Default(<GeneralRecordPhoto>[]) List<GeneralRecordPhoto> draftPhotos,
    @Default(false) bool selectingPhotos,
    String? validationMessage,
  }) = _GeneralRecordState;

  const GeneralRecordState._();
}
