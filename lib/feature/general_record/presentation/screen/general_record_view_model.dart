import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/general_record.dart';
import '../../domain/model/general_record_photo.dart';
import 'general_record_action.dart';
import 'general_record_event.dart';
import 'general_record_state.dart';

class GeneralRecordViewModel extends Notifier<GeneralRecordState> {
  static const int maximumPhotoCount = 5;
  static const int maximumContentLength = 1000;

  final StreamController<GeneralRecordEvent> _events =
      StreamController<GeneralRecordEvent>.broadcast();

  Stream<GeneralRecordEvent> get eventStream => _events.stream;

  @override
  GeneralRecordState build() {
    ref.onDispose(_events.close);
    return const GeneralRecordState();
  }

  void onAction(GeneralRecordAction action) {
    switch (action) {
      case TapBackButton():
        break;
      case GeneralRecordCreateRequested():
        _openEditor();
      case GeneralRecordEditRequested(:final id):
        _openEditor(id: id);
      case GeneralRecordEditorDismissed():
        _closeEditor();
      case GeneralRecordContentChanged(:final content):
        state = state.copyWith(draftContent: content, validationMessage: null);
      case GeneralRecordDateChanged(:final date):
        state = state.copyWith(
          draftDate: date,
          calendarMonth: DateTime(date.year, date.month),
          calendarVisible: false,
        );
      case GeneralRecordCalendarVisibilityChanged(:final visible):
        state = state.copyWith(
          calendarVisible: visible,
          calendarMonth: visible && state.draftDate != null
              ? DateTime(state.draftDate!.year, state.draftDate!.month)
              : state.calendarMonth,
        );
      case GeneralRecordCalendarMonthChanged(:final month):
        state = state.copyWith(
          calendarMonth: DateTime(month.year, month.month),
        );
      case GeneralRecordPhotoSelectionRequested():
        _requestPhotos();
      case GeneralRecordPhotosAdded(:final photos):
        final remaining = maximumPhotoCount - state.draftPhotos.length;
        state = state.copyWith(
          selectingPhotos: false,
          draftPhotos: <GeneralRecordPhoto>[
            ...state.draftPhotos,
            ...photos.take(remaining),
          ],
        );
      case GeneralRecordPhotoRemoved(:final id):
        state = state.copyWith(
          draftPhotos: state.draftPhotos
              .where((photo) => photo.id != id)
              .toList(growable: false),
        );
      case GeneralRecordViewModeSelected(:final mode):
        state = state.copyWith(viewMode: mode);
      case GeneralRecordSaveRequested():
        _saveDraft();
    }
  }

  void _openEditor({String? id}) {
    GeneralRecord? existing;
    if (id != null) {
      for (final entry in state.entries) {
        if (entry.id == id) {
          existing = entry;
          break;
        }
      }
    }
    final date = existing?.recordedAt ?? DateTime.now();

    state = state.copyWith(
      editorOpen: true,
      editorSessionId: state.editorSessionId + 1,
      editingId: existing?.id,
      draftContent: existing?.content ?? '',
      draftDate: date,
      calendarMonth: DateTime(date.year, date.month),
      calendarVisible: false,
      draftPhotos: existing?.photos ?? const [],
      selectingPhotos: false,
      validationMessage: null,
    );
  }

  void _closeEditor() {
    state = state.copyWith(
      editorOpen: false,
      editingId: null,
      draftContent: '',
      draftDate: null,
      calendarMonth: null,
      calendarVisible: false,
      draftPhotos: const [],
      selectingPhotos: false,
      validationMessage: null,
    );
  }

  void _requestPhotos() {
    final remaining = maximumPhotoCount - state.draftPhotos.length;
    if (remaining <= 0 || state.selectingPhotos) return;

    state = state.copyWith(selectingPhotos: true);
    _events.add(GeneralRecordEvent.selectPhotos(remaining));
  }

  void _saveDraft() {
    final content = state.draftContent;
    if (content.trim().isEmpty) {
      state = state.copyWith(validationMessage: '기억할 내용을 적어주세요.');
      return;
    }
    if (content.length > maximumContentLength) {
      state = state.copyWith(validationMessage: '내용은 1,000자 이내로 적어주세요.');
      return;
    }

    final recordedAt = state.draftDate ?? DateTime.now();
    final updatedRecord = state.editingId == null
        ? GeneralRecord(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            content: content,
            recordedAt: recordedAt,
            photos: state.draftPhotos,
          )
        : GeneralRecord(
            id: state.editingId!,
            content: content,
            recordedAt: recordedAt,
            photos: state.draftPhotos,
          );
    final updatedEntries = state.editingId == null
        ? <GeneralRecord>[updatedRecord, ...state.entries]
        : state.entries
              .map(
                (GeneralRecord entry) =>
                    entry.id == updatedRecord.id ? updatedRecord : entry,
              )
              .toList(growable: false);

    state = state.copyWith(entries: updatedEntries);
    _closeEditor();
  }
}

final generalRecordViewModelProvider =
    NotifierProvider<GeneralRecordViewModel, GeneralRecordState>(
      GeneralRecordViewModel.new,
    );
