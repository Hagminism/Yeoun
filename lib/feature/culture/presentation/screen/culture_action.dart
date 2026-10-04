import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/culture_kind.dart';

part 'culture_action.freezed.dart';

@freezed
sealed class CultureAction with _$CultureAction {
  const factory CultureAction.navigateBackRequested() =
      CultureNavigateBackRequested;
  const factory CultureAction.memberSelected(String memberId) =
      CultureMemberSelected;
  const factory CultureAction.workCreationRequested() =
      CultureWorkCreationRequested;
  const factory CultureAction.workEditRequested(String workId) =
      CultureWorkEditRequested;
  const factory CultureAction.editorClosed() = CultureEditorClosed;
  const factory CultureAction.artworkPickRequested() =
      CultureArtworkPickRequested;
  const factory CultureAction.artworkPicked(String artworkBase64) =
      CultureArtworkPicked;
  const factory CultureAction.artworkPickCancelled() =
      CultureArtworkPickCancelled;
  const factory CultureAction.artworkPickFailed(String message) =
      CultureArtworkPickFailed;
  const factory CultureAction.workSaved({
    String? workId,
    required CultureKind kind,
    required String title,
    required double rating,
    required String review,
    required DateTime reviewedAt,
  }) = CultureWorkSaved;
}
