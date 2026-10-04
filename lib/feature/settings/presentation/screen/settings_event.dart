import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
sealed class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.composeFeatureRequest() =
      SettingsComposeFeatureRequest;
  const factory SettingsEvent.editSpaceTitle() = SettingsEditSpaceTitle;
  const factory SettingsEvent.editProfile() = SettingsEditProfile;
  const factory SettingsEvent.editWidgets() = SettingsEditWidgets;
  const factory SettingsEvent.editAnniversary() = SettingsEditAnniversary;
  const factory SettingsEvent.showInfo(String title, String message) =
      SettingsShowInfo;
  const factory SettingsEvent.confirmLogout() = SettingsConfirmLogout;
  const factory SettingsEvent.confirmAccountWithdrawal() =
      SettingsConfirmAccountWithdrawal;
}
