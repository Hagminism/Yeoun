import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/culture_mock_data.dart';
import '../../domain/model/culture_kind.dart';
import '../../domain/model/culture_member.dart';
import '../../domain/model/culture_review.dart';
import '../../domain/model/culture_work.dart';
import 'culture_action.dart';
import 'culture_event.dart';
import 'culture_state.dart';

class CultureViewModel extends Notifier<CultureState> {
  final StreamController<CultureEvent> _events =
      StreamController<CultureEvent>.broadcast();

  Stream<CultureEvent> get eventStream => _events.stream;

  @override
  CultureState build() {
    ref.onDispose(_events.close);
    return CultureState(
      works: CultureMockData.works,
      members: CultureMockData.members,
    );
  }

  void onAction(CultureAction action) {
    switch (action) {
      case CultureNavigateBackRequested():
        _events.add(const CultureEvent.navigateBack());
      case CultureWorkCreationRequested():
        state = state.copyWith(
          editorVisible: true,
          editingWorkId: null,
          pendingArtworkBase64: '',
          editorMessage: null,
        );
      case CultureWorkEditRequested(:final workId):
        if (state.works.any((CultureWork work) => work.id == workId)) {
          state = state.copyWith(
            editorVisible: true,
            editingWorkId: workId,
            pendingArtworkBase64: '',
            editorMessage: null,
          );
        }
      case CultureEditorClosed():
        _closeEditor();
      case CultureArtworkPickRequested():
        state = state.copyWith(isPickingArtwork: true, editorMessage: null);
        _events.add(const CultureEvent.pickArtwork());
      case CultureArtworkPicked(:final artworkBase64):
        state = state.copyWith(
          pendingArtworkBase64: artworkBase64,
          isPickingArtwork: false,
          editorMessage: null,
        );
      case CultureArtworkPickCancelled():
        state = state.copyWith(isPickingArtwork: false);
      case CultureArtworkPickFailed(:final message):
        state = state.copyWith(isPickingArtwork: false, editorMessage: message);
      case CultureWorkSaved(
        :final workId,
        :final kind,
        :final title,
        :final rating,
        :final review,
        :final reviewedAt,
      ):
        _saveWork(
          workId: workId,
          kind: kind,
          title: title,
          rating: rating,
          review: review,
          reviewedAt: reviewedAt,
        );
    }
  }

  void _saveWork({
    required String? workId,
    required CultureKind kind,
    required String title,
    required double rating,
    required String review,
    required DateTime reviewedAt,
  }) {
    final String cleanTitle = title.trim();
    if (cleanTitle.isEmpty || rating < 1 || rating > 10 || rating % 1 != 0) {
      state = state.copyWith(editorMessage: '작품명과 1점 단위 평점을 확인해 주세요.');
      return;
    }

    CultureWork? previous = workId == null ? null : _findWork(workId);
    if (previous == null) {
      for (final CultureWork work in state.works) {
        if (work.kind == kind &&
            work.title.trim().toLowerCase() == cleanTitle.toLowerCase()) {
          previous = work;
          break;
        }
      }
    }
    final String id =
        previous?.id ?? 'culture-${DateTime.now().microsecondsSinceEpoch}';
    final CultureMember activeMember = state.members.firstWhere(
      (CultureMember member) => member.id == state.activeMemberId,
    );
    final CultureReview nextReview = CultureReview(
      memberId: activeMember.id,
      memberName: activeMember.name,
      rating: rating,
      review: review.trim(),
      reviewedAt: reviewedAt,
    );
    final List<CultureReview> reviews = <CultureReview>[
      if (previous != null)
        for (final CultureReview existingReview in previous.reviews)
          if (existingReview.memberId != activeMember.id) existingReview,
      nextReview,
    ];
    final CultureWork nextWork = CultureWork(
      id: id,
      kind: kind,
      title: cleanTitle,
      artworkBase64: state.pendingArtworkBase64.isNotEmpty
          ? state.pendingArtworkBase64
          : previous?.artworkBase64 ?? '',
      artworkAsset: previous?.artworkAsset ?? '',
      reviews: reviews,
    );
    final List<CultureWork> works = <CultureWork>[
      nextWork,
      for (final CultureWork work in state.works)
        if (work.id != nextWork.id) work,
    ];
    state = state.copyWith(
      works: works,
      editorVisible: false,
      editingWorkId: null,
      pendingArtworkBase64: '',
      editorMessage: null,
      isPickingArtwork: false,
    );
  }

  CultureWork? _findWork(String id) {
    for (final CultureWork work in state.works) {
      if (work.id == id) return work;
    }
    return null;
  }

  void _closeEditor() {
    state = state.copyWith(
      editorVisible: false,
      editingWorkId: null,
      pendingArtworkBase64: '',
      isPickingArtwork: false,
      editorMessage: null,
    );
  }
}

final cultureViewModelProvider =
    NotifierProvider<CultureViewModel, CultureState>(CultureViewModel.new);
