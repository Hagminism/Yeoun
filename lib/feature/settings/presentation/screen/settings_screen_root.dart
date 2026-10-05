import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature/home/presentation/screen/home_view_model.dart';
import '../../../../ui/presentation/component/dialog/app_dialog.dart';
import '../../../home/presentation/component/dialog/home_text_input_dialog.dart';
import '../../../home/presentation/component/dialog/home_widget_editor.dart';
import '../../../home/presentation/screen/home_action.dart';
import '../component/settings_header.dart';
import 'settings_action.dart';
import 'settings_event.dart';
import 'settings_screen.dart';
import 'settings_view_model.dart';

class SettingsScreenRoot extends ConsumerStatefulWidget {
  const SettingsScreenRoot({super.key});

  @override
  ConsumerState<SettingsScreenRoot> createState() => _SettingsScreenRootState();
}

class _SettingsScreenRootState extends ConsumerState<SettingsScreenRoot> {
  StreamSubscription<SettingsEvent>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    final viewModel = ref.read(settingsViewModelProvider.notifier);
    _eventSubscription = viewModel.eventStream.listen(_handleEvent);
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(settingsViewModelProvider.notifier);

    final settingsState = ref.watch(settingsViewModelProvider);
    final homeState = ref.watch(homeViewModelProvider);

    return Column(
      children: [
        SettingsHeader(
          onFeatureRequest: () {
            viewModel.onAction(const SettingsAction.featureRequestRequested());
          },
          onNotifications: () {
            viewModel.onAction(
              const SettingsAction.notificationsSummaryRequested(),
            );
          },
          onSettings: () {
            viewModel.onAction(const SettingsAction.screenSummaryRequested());
          },
        ),
        Expanded(
          child: SettingsScreen(
            state: settingsState,
            homeState: homeState,
            onAction: viewModel.onAction,
          ),
        ),
      ],
    );
  }

  Future<void> _handleEvent(SettingsEvent event) async {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    switch (event) {
      case SettingsComposeFeatureRequest():
        await _showFeatureRequest();
      case SettingsEditSpaceTitle():
        await _showTextInput(
          title: '공간 이름 수정',
          hint: '공간 이름을 적어주세요',
          initialValue: ref.read(homeViewModelProvider).spaceTitle,
          onSave: (String value) {
            homeViewModel.onAction(HomeAction.spaceRenamed(value));
          },
        );
      case SettingsEditProfile():
        await _showInfo('프로필 수정', '프로필 정보 수정은 준비 중이에요.');
      case SettingsEditWidgets():
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          constraints: const BoxConstraints(maxWidth: 560),
          builder: (BuildContext sheetContext) {
            return Consumer(
              builder:
                  (BuildContext context, WidgetRef sheetRef, Widget? child) {
                    return HomeWidgetEditor(
                      configs: sheetRef
                          .watch(homeViewModelProvider)
                          .widgetConfigs,
                      onVisibilityChanged: (String id, bool visible) {
                        homeViewModel.onAction(
                          HomeAction.widgetVisibilityChanged(id, visible),
                        );
                      },
                      onReorder: (int from, int to) {
                        homeViewModel.onAction(
                          HomeAction.widgetsReordered(from, to),
                        );
                      },
                      onClose: () {
                        Navigator.of(sheetContext).pop();
                      },
                    );
                  },
            );
          },
        );
      case SettingsEditAnniversary():
        final anniversary = ref.read(homeViewModelProvider).anniversary;
        final startDate = anniversary.startLabel.replaceAll('~', '').trim();
        await _showInfo(
          '기념일 및 D-Day 설정',
          '처음 만난 날 $startDate · D+${anniversary.daysTogether}일째 함께하고 있어요.\n기념일 수정은 준비 중이에요.',
        );
      case SettingsShowInfo(:final title, :final message):
        await _showInfo(title, message);
      case SettingsConfirmLogout():
        await _showAccountAction(
          title: '로그아웃',
          message: '로그아웃 기능은 준비 중이에요.',
          actionLabel: '로그아웃',
        );
      case SettingsConfirmAccountWithdrawal():
        await _showAccountAction(
          title: '회원 탈퇴',
          message: '회원 탈퇴 기능은 준비 중이에요.',
          actionLabel: '탈퇴',
        );
    }
  }

  Future<void> _showFeatureRequest() async {
    final controller = TextEditingController();
    final result = await AppDialog.show<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AppDialog(
          title: '기능 요청하기',
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: '함께 만들고 싶은 기능을 적어주세요',
              border: OutlineInputBorder(),
            ),
          ),
          cancelLabel: '닫기',
          onCancel: () {
            Navigator.of(dialogContext).pop();
          },
          confirmLabel: '보내기',
          onConfirm: () {
            Navigator.of(dialogContext).pop(controller.text.trim());
          },
        );
      },
    );
    await Future<void>.delayed(const Duration(milliseconds: 300));
    controller.dispose();

    if (!mounted || result == null || result.isEmpty) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('기능 요청 전송은 준비 중이에요.')));
  }

  Future<void> _showTextInput({
    required String title,
    required String hint,
    required void Function(String) onSave,
    String initialValue = '',
  }) async {
    final controller = TextEditingController(text: initialValue);
    final value = await AppDialog.show<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return HomeTextInputDialog(
          title: title,
          hint: hint,
          controller: controller,
          onCancel: () {
            Navigator.of(dialogContext).pop();
          },
          onSave: (String input) {
            Navigator.of(dialogContext).pop(input.trim());
          },
        );
      },
    );
    await Future<void>.delayed(const Duration(milliseconds: 300));
    controller.dispose();

    if (mounted && value != null && value.isNotEmpty) {
      onSave(value);
    }
  }

  Future<void> _showInfo(String title, String message) {
    return AppDialog.show<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AppDialog(
          title: title,
          message: message,
          confirmLabel: '닫기',
          onConfirm: () {
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }

  Future<void> _showAccountAction({
    required String title,
    required String message,
    required String actionLabel,
  }) async {
    final confirmed = await AppDialog.show<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AppDialog(
          title: title,
          message: message,
          cancelLabel: '취소',
          onCancel: () {
            Navigator.of(dialogContext).pop(false);
          },
          confirmLabel: actionLabel,
          onConfirm: () {
            Navigator.of(dialogContext).pop(true);
          },
        );
      },
    );

    if (mounted && confirmed == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$actionLabel 기능은 준비 중이에요.')));
    }
  }
}
