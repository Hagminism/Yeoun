import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/routes.dart';
import '../../../../di/home_view_model_provider.dart';
import '../../../../ui/app_text_styles.dart';
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
      switch (event) {
        case HomeNavigateHome():
          if (!mounted) return;
          context.go(Routes.home);
        case HomeComposeBucket():
          if (!mounted) return;
          await _showTextInput(
            context,
            title: '새 버킷 추가하기',
            hint: '함께 하고 싶은 일을 적어주세요',
            onSave: (String value) {
              viewModel.onAction(HomeAction.bucketAdded(value));
            },
          );
        case HomeComposeMemo():
          if (!mounted) return;
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
          if (!mounted) return;
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
          if (!mounted) return;
          await showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text(type.label, style: AppTextStyles.cardTitle),
                content: SizedBox(
                  width: 400,
                  child: SingleChildScrollView(
                    child: HomeDetailContent(
                      type: type,
                      state: ref.read(homeViewModelProvider),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('닫기'),
                  ),
                ],
              );
            },
          );
        case HomeChooseRecord():
          if (!mounted) return;
          final selection = await showDialog<bool>(
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
          if (!mounted) return;
          await showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('알림', style: AppTextStyles.cardTitle),
                content: const Text('새로운 알림이 없어요.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('닫기'),
                  ),
                ],
              );
            },
          );
        case HomeOpenSettings():
          if (!mounted) return;
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
      onAction: viewModel.onAction,
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
    final value = await showDialog<String>(
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
