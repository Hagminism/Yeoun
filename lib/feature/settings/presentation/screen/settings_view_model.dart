import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_action.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsViewModel extends Notifier<SettingsState> {
  final StreamController<SettingsEvent> _events =
      StreamController<SettingsEvent>.broadcast();

  Stream<SettingsEvent> get eventStream => _events.stream;

  @override
  SettingsState build() {
    ref.onDispose(_events.close);
    return const SettingsState();
  }

  void onAction(SettingsAction action) {
    switch (action) {
      case SettingsNotificationsChanged(:final enabled):
        state = state.copyWith(notificationsEnabled: enabled);
      case SettingsDailyQuestionChanged(:final enabled):
        state = state.copyWith(dailyQuestionEnabled: enabled);
      case SettingsNotificationsSummaryRequested():
        _events.add(
          const SettingsEvent.showInfo(
            '알림',
            '타임캡슐 개봉과 파트너 소식을 알림으로 확인할 수 있어요.',
          ),
        );
      case SettingsScreenSummaryRequested():
        _events.add(
          const SettingsEvent.showInfo(
            '설정',
            '공간, 기록 보관, 알림과 보안 설정을 관리하는 화면이에요.',
          ),
        );
      case SettingsFeatureRequestRequested():
        _events.add(const SettingsEvent.composeFeatureRequest());
      case SettingsSpaceTitleEditRequested():
        _events.add(const SettingsEvent.editSpaceTitle());
      case SettingsProfileEditRequested():
        _events.add(const SettingsEvent.editProfile());
      case SettingsPartnerManagementRequested():
        _events.add(
          const SettingsEvent.showInfo(
            '파트너 연결 및 초대 관리',
            '파트너 초대와 연결 관리는 준비 중이에요.',
          ),
        );
      case SettingsWidgetsEditRequested():
        _events.add(const SettingsEvent.editWidgets());
      case SettingsAnniversaryEditRequested():
        _events.add(const SettingsEvent.editAnniversary());
      case SettingsStorageManagementRequested():
        _events.add(
          const SettingsEvent.showInfo(
            '용량 및 저장소 관리',
            '현재 사용량은 1.2 GB / 15 GB예요. 저장소 관리는 준비 중이에요.',
          ),
        );
      case SettingsDataExportRequested():
        _events.add(
          const SettingsEvent.showInfo(
            '추억 데이터 내보내기',
            '사진, 일기, 캡슐 데이터를 PDF 파일로 내보내는 기능은 준비 중이에요.',
          ),
        );
      case SettingsCloudSyncRequested():
        _events.add(
          const SettingsEvent.showInfo(
            '실시간 동기화 & 클라우드 백업',
            '마지막 동기화는 오늘 14:22에 완료되었어요. 백업 기능은 준비 중이에요.',
          ),
        );
      case SettingsThemeSettingsRequested():
        _events.add(
          const SettingsEvent.showInfo(
            '테마 및 폰트 설정',
            '현재 테마는 아틀리에 웜 화이트, 폰트는 Pretendard예요.',
          ),
        );
      case SettingsSecuritySettingsRequested():
        _events.add(
          const SettingsEvent.showInfo('앱 잠금 및 보안', '앱 잠금과 생체 인증 설정은 준비 중이에요.'),
        );
      case SettingsNoticesRequested():
        _events.add(
          const SettingsEvent.showInfo('공지사항 및 업데이트 이야기', '새로운 공지사항이 없어요.'),
        );
      case SettingsContactRequested():
        _events.add(
          const SettingsEvent.showInfo('기능 제안 및 문의하기', '문의 기능은 준비 중이에요.'),
        );
      case SettingsTermsRequested():
        _events.add(
          const SettingsEvent.showInfo(
            '서비스 이용약관 / 개인정보 처리방침',
            '약관과 개인정보 처리방침은 준비 중이에요.',
          ),
        );
      case SettingsAccountManagementRequested():
        _events.add(
          const SettingsEvent.showInfo('계정 관리', '계정 정보 관리는 준비 중이에요.'),
        );
      case SettingsLogoutRequested():
        _events.add(const SettingsEvent.confirmLogout());
      case SettingsAccountWithdrawalRequested():
        _events.add(const SettingsEvent.confirmAccountWithdrawal());
    }
  }
}

final settingsViewModelProvider =
    NotifierProvider.autoDispose<SettingsViewModel, SettingsState>(
      SettingsViewModel.new,
    );
