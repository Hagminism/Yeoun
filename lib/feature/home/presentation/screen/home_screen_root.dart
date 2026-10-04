import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import 'home_view_model.dart';
import '../../../../ui/presentation/component/app_dialog.dart';
import 'home_action.dart';
import 'home_event.dart';
import 'home_screen.dart';
import '../component/detail/home_detail_content.dart';
import '../component/dialog/home_record_menu.dart';
import '../component/dialog/home_text_input_dialog.dart';
import '../component/dialog/home_widget_editor.dart';

class HomeScreenRoot extends ConsumerStatefulWidget {
  const HomeScreenRoot({super.key});

  @override
  ConsumerState<HomeScreenRoot> createState() => _HomeScreenRootState();
}

class _HomeScreenRootState extends ConsumerState<HomeScreenRoot> {
  StreamSubscription<HomeEvent>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    final viewModel = ref.read(homeViewModelProvider.notifier);

    _eventSubscription = viewModel.eventStream.listen((HomeEvent event) async {
      if (!mounted) return;

      switch (event) {
        case HomeNavigateHome():
          context.go(Routes.home);
        case HomeComposeBucket():
          await _showTextInput(
            context,
            title: '새 버킷 추가하기',
            hint: '함께 하고 싶은 일을 적어주세요',
            onSave: (String value) {
              viewModel.onAction(HomeAction.bucketAdded(value));
            },
          );
        case HomeComposeMemo():
          await _showTextInput(
            context,
            title: '오늘의 일기',
            hint: '오늘 기억하고 싶은 순간은 무엇인가요?',
            multiline: true,
            onSave: (String value) {
              viewModel.onAction(HomeAction.memoSaved(value));
            },
          );
        case HomeEditWidgets():
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
                        onVisibilityChanged: (String id, bool value) {
                          viewModel.onAction(
                            HomeAction.widgetVisibilityChanged(id, value),
                          );
                        },
                        onReorder: (int from, int to) {
                          viewModel.onAction(
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
        case HomeOpenDetail(:final type):
          await AppDialog.show<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AppDialog(
                title: type.label,
                content: HomeDetailContent(
                  type: type,
                  state: ref.read(homeViewModelProvider),
                ),
                confirmLabel: '닫기',
                onConfirm: () {
                  Navigator.of(dialogContext).pop();
                },
              );
            },
          );
        case HomeChooseRecord():
          final selection = await AppDialog.show<bool>(
            context: context,
            builder: (BuildContext dialogContext) {
              return HomeRecordMenu(
                onMemo: () {
                  Navigator.of(dialogContext).pop(true);
                },
                onBucket: () {
                  Navigator.of(dialogContext).pop(false);
                },
                onClose: () {
                  Navigator.of(dialogContext).pop();
                },
              );
            },
          );
          if (!mounted || selection == null) return;
          viewModel.onAction(
            selection
                ? const HomeAction.memoRequested()
                : const HomeAction.addBucketRequested(),
          );
        case HomeShowNotifications():
          await AppDialog.show<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AppDialog(
                title: '알림',
                message: '새로운 알림이 없어요.',
                confirmLabel: '닫기',
                onConfirm: () {
                  Navigator.of(dialogContext).pop();
                },
              );
            },
          );
        case HomeOpenSettings():
          await _showTextInput(
            context,
            title: '공간 이름',
            hint: '공간 이름을 적어주세요',
            initialValue: ref.read(homeViewModelProvider).spaceTitle,
            onSave: (String value) {
              viewModel.onAction(HomeAction.spaceRenamed(value));
            },
          );
      }
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(homeViewModelProvider.notifier);

    return HomeScreen(
      state: ref.watch(homeViewModelProvider),
      onAction: (HomeAction action) {
        switch (action) {
          case HomeSettingsRequested():
            context.go(Routes.settings);
          default:
            viewModel.onAction(action);
        }
      },
    );
  }

  Future<void> _showTextInput(
    BuildContext context, {
    required String title,
    required String hint,
    required void Function(String) onSave,
    String initialValue = '',
    bool multiline = false,
  }) async {
    final controller = TextEditingController(text: initialValue);
    final value = await AppDialog.show<String>(
      context: context,
      builder: (BuildContext dialogContext) {
        return HomeTextInputDialog(
          title: title,
          hint: hint,
          controller: controller,
          multiline: multiline,
          onCancel: () {
            Navigator.of(dialogContext).pop();
          },
          onSave: (String value) {
            Navigator.of(dialogContext).pop(value.trim());
          },
        );
      },
    );
    // 다이얼로그의 닫힘 애니메이션 동안 입력 위젯이 컨트롤러를 참조한다.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    controller.dispose();
    if (context.mounted && value != null) onSave(value);
  }
}
