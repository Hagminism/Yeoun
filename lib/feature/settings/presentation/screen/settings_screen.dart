import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../ui/app_colors.dart';
import '../../../../ui/app_text_styles.dart';
import '../../../home/presentation/screen/home_state.dart';
import '../component/settings_footer_action.dart';
import '../component/settings_info_row.dart';
import '../component/settings_label_badge.dart';
import '../component/settings_profile_summary.dart';
import '../component/settings_quick_action.dart';
import '../component/settings_section_card.dart';
import '../component/settings_storage_row.dart';
import '../component/settings_theme_dot.dart';
import '../component/settings_toggle.dart';
import 'settings_action.dart';
import 'settings_state.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsState state;
  final HomeState homeState;
  final void Function(SettingsAction) onAction;

  const SettingsScreen({
    super.key,
    required this.state,
    required this.homeState,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = homeState.anniversary.startLabel
        .replaceAll('~', '')
        .trim();
    final scrollBottomPadding = math.max(
      32.0,
      MediaQuery.paddingOf(context).bottom + 16,
    );

    return ColoredBox(
      color: AppColors.paper,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView(
            padding: EdgeInsets.fromLTRB(16, 8, 16, scrollBottomPadding),
            children: [
              SettingsQuickAction(
                onPressed: () {
                  onAction(const SettingsAction.featureRequestRequested());
                },
              ),
              const SizedBox(height: 16),
              SettingsProfileSummary(
                spaceTitle: homeState.spaceTitle,
                anniversary: homeState.anniversary,
                onEditSpaceTitle: () {
                  onAction(const SettingsAction.spaceTitleEditRequested());
                },
                onEditProfile: () {
                  onAction(const SettingsAction.profileEditRequested());
                },
              ),
              SettingsSectionCard(
                title: 'Space 관리',
                rows: [
                  SettingsInfoRow(
                    title: '파트너 연결 및 초대 관리',
                    description: '박준혁 님과 $startDate부터 기록 중',
                    onTap: () {
                      onAction(
                        const SettingsAction.partnerManagementRequested(),
                      );
                    },
                  ),
                  SettingsInfoRow(
                    title: 'Space 위젯 순서 및 추가',
                    description: '타임캡슐, 버킷, 공유 앨범 배치 관리',
                    onTap: () {
                      onAction(const SettingsAction.widgetsEditRequested());
                    },
                  ),
                  SettingsInfoRow(
                    title: '기념일 및 D-Day 설정',
                    description:
                        '처음 만난 날 · $startDate (D+${homeState.anniversary.daysTogether})',
                    onTap: () {
                      onAction(const SettingsAction.anniversaryEditRequested());
                    },
                  ),
                ],
              ),
              SettingsSectionCard(
                title: '기록 및 보관',
                rows: [
                  SettingsStorageRow(
                    onTap: () {
                      onAction(
                        const SettingsAction.storageManagementRequested(),
                      );
                    },
                  ),
                  SettingsInfoRow(
                    title: '추억 데이터 내보내기',
                    description: '우리가 나눈 글과 사진을 파일로 저장',
                    trailing: const SettingsLabelBadge(
                      label: 'PDF/인쇄',
                      foreground: AppColors.coralDeep,
                      background: AppColors.coralSoft,
                    ),
                    onTap: () {
                      onAction(const SettingsAction.dataExportRequested());
                    },
                  ),
                  SettingsInfoRow(
                    title: '실시간 동기화 & 클라우드 백업',
                    description: '마지막 동기화: 오늘 14:22 완료',
                    onTap: () {
                      onAction(const SettingsAction.cloudSyncRequested());
                    },
                  ),
                ],
              ),
              SettingsSectionCard(
                title: '환경설정',
                rows: [
                  SettingsInfoRow(
                    title: '알림 설정',
                    description: '타임캡슐 개봉 및 파트너 새 소식',
                    trailing: SettingsToggle(
                      value: state.notificationsEnabled,
                      onChanged: (bool value) {
                        onAction(SettingsAction.notificationsChanged(value));
                      },
                    ),
                    onTap: () {
                      onAction(
                        SettingsAction.notificationsChanged(
                          !state.notificationsEnabled,
                        ),
                      );
                    },
                  ),
                  SettingsInfoRow(
                    title: '하루 한 줄 질문 알림',
                    description: '매일 저녁 9시 함께 답하는 질문',
                    trailing: SettingsToggle(
                      value: state.dailyQuestionEnabled,
                      onChanged: (bool value) {
                        onAction(SettingsAction.dailyQuestionChanged(value));
                      },
                    ),
                    onTap: () {
                      onAction(
                        SettingsAction.dailyQuestionChanged(
                          !state.dailyQuestionEnabled,
                        ),
                      );
                    },
                  ),
                  SettingsInfoRow(
                    title: '테마 및 폰트 설정',
                    description: '아틀리에 웜 화이트 · Pretendard',
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SettingsThemeDot(),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    ),
                    onTap: () {
                      onAction(const SettingsAction.themeSettingsRequested());
                    },
                  ),
                  SettingsInfoRow(
                    title: '앱 잠금 및 보안',
                    description: '실행 시 화면 잠금 및 추억 보호',
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SettingsLabelBadge(
                          label: 'Face ID',
                          foreground: AppColors.bodyText,
                          background: AppColors.creamDeep,
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: AppColors.secondaryText,
                        ),
                      ],
                    ),
                    onTap: () {
                      onAction(
                        const SettingsAction.securitySettingsRequested(),
                      );
                    },
                  ),
                ],
              ),
              SettingsSectionCard(
                title: '고객지원 및 정보',
                rows: [
                  SettingsInfoRow(
                    title: '공지사항 및 업데이트 이야기',
                    onTap: () {
                      onAction(const SettingsAction.noticesRequested());
                    },
                  ),
                  SettingsInfoRow(
                    title: '기능 제안 및 문의하기',
                    onTap: () {
                      onAction(const SettingsAction.contactRequested());
                    },
                  ),
                  SettingsInfoRow(
                    title: '서비스 이용약관 / 개인정보 처리방침',
                    onTap: () {
                      onAction(const SettingsAction.termsRequested());
                    },
                  ),
                  SettingsInfoRow(
                    title: '계정 관리',
                    onTap: () {
                      onAction(
                        const SettingsAction.accountManagementRequested(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SettingsFooterAction(
                    label: '로그아웃',
                    onTap: () {
                      onAction(const SettingsAction.logoutRequested());
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('·'),
                  ),
                  SettingsFooterAction(
                    label: '회원 탈퇴',
                    onTap: () {
                      onAction(
                        const SettingsAction.accountWithdrawalRequested(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  '여운 v1.0.0 · 소중한 모든 순간을 영원히',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.disabledText,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
