import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/culture_member.dart';
import '../../domain/model/culture_work.dart';

part 'culture_state.freezed.dart';

@freezed
abstract class CultureState with _$CultureState {
  const factory CultureState({
    @Default(<CultureWork>[]) List<CultureWork> works,
    @Default(<CultureMember>[]) List<CultureMember> members,
    @Default('member-jiwoo') String activeMemberId,
    @Default(false) bool editorVisible,
    String? editingWorkId,
    @Default('') String pendingArtworkBase64,
    @Default(false) bool isPickingArtwork,
    String? editorMessage,
  }) = _CultureState;
}
