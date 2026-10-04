import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(true) bool notificationsEnabled,
    @Default(true) bool dailyQuestionEnabled,
  }) = _SettingsState;
}
