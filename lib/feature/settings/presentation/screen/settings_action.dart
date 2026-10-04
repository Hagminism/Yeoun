import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_action.freezed.dart';

@freezed
sealed class SettingsAction with _$SettingsAction {
  const factory SettingsAction.notificationsChanged(bool enabled) =
      SettingsNotificationsChanged;
  const factory SettingsAction.dailyQuestionChanged(bool enabled) =
      SettingsDailyQuestionChanged;
  const factory SettingsAction.notificationsSummaryRequested() =
      SettingsNotificationsSummaryRequested;
  const factory SettingsAction.screenSummaryRequested() =
      SettingsScreenSummaryRequested;
  const factory SettingsAction.featureRequestRequested() =
      SettingsFeatureRequestRequested;
  const factory SettingsAction.spaceTitleEditRequested() =
      SettingsSpaceTitleEditRequested;
  const factory SettingsAction.profileEditRequested() =
      SettingsProfileEditRequested;
  const factory SettingsAction.partnerManagementRequested() =
      SettingsPartnerManagementRequested;
  const factory SettingsAction.widgetsEditRequested() =
      SettingsWidgetsEditRequested;
  const factory SettingsAction.anniversaryEditRequested() =
      SettingsAnniversaryEditRequested;
  const factory SettingsAction.storageManagementRequested() =
      SettingsStorageManagementRequested;
  const factory SettingsAction.dataExportRequested() =
      SettingsDataExportRequested;
  const factory SettingsAction.cloudSyncRequested() =
      SettingsCloudSyncRequested;
  const factory SettingsAction.themeSettingsRequested() =
      SettingsThemeSettingsRequested;
  const factory SettingsAction.securitySettingsRequested() =
      SettingsSecuritySettingsRequested;
  const factory SettingsAction.noticesRequested() = SettingsNoticesRequested;
  const factory SettingsAction.contactRequested() = SettingsContactRequested;
  const factory SettingsAction.termsRequested() = SettingsTermsRequested;
  const factory SettingsAction.accountManagementRequested() =
      SettingsAccountManagementRequested;
  const factory SettingsAction.logoutRequested() = SettingsLogoutRequested;
  const factory SettingsAction.accountWithdrawalRequested() =
      SettingsAccountWithdrawalRequested;
}
