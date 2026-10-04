import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../feature/home/presentation/screen/home_action.dart';
import '../../../../core/routing/routes.dart';
import '../../../../ui/presentation/component/app_dialog.dart';
import '../../../home/presentation/screen/home_view_model.dart';
import '../../data/mapper/bucket_list_entry_mapper.dart';
import 'bucket_list_action.dart';
import 'bucket_list_event.dart';
import 'bucket_list_screen.dart';
import 'bucket_list_view_model.dart';

class BucketListScreenRoot extends ConsumerStatefulWidget {
  const BucketListScreenRoot({super.key});

  @override
  ConsumerState<BucketListScreenRoot> createState() =>
      _BucketListScreenRootState();
}

class _BucketListScreenRootState extends ConsumerState<BucketListScreenRoot> {
  final GlobalKey<FormState> _inputFormKey = GlobalKey<FormState>();
  final FocusNode _inputFocusNode = FocusNode();
  StreamSubscription<BucketListEvent>? _eventSubscription;

  @override
  void initState() {
    super.initState();
    final viewModel = ref.read(bucketListViewModelProvider.notifier);

    _eventSubscription = viewModel.eventStream.listen((event) {
      if (!mounted) return;

      switch (event) {
        case BucketListAddBucket(:final title):
          ref
              .read(homeViewModelProvider.notifier)
              .onAction(HomeAction.bucketAdded(title));
          _inputFormKey.currentState?.reset();
        case BucketListToggleBucket(:final id):
          ref
              .read(homeViewModelProvider.notifier)
              .onAction(HomeAction.toggleBucket(id));
        case BucketListShowNotifications():
          unawaited(_showNotifications());
      }
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(bucketListViewModelProvider.notifier);
    final bucketState = ref.watch(bucketListViewModelProvider);
    final homeState = ref.watch(homeViewModelProvider);

    return BucketListScreen(
      state: bucketState,
      entries: BucketListEntryMapper.fromHomeItems(homeState.buckets),
      inputFormKey: _inputFormKey,
      inputFocusNode: _inputFocusNode,
      onOpenSettings: () {
        context.go(Routes.settings);
      },
      onAction: (BucketListAction action) {
        switch (action) {
          case BucketListFocusInputRequested():
            _inputFocusNode.requestFocus();
          case BucketListNavigationSelected():
            break;
          case BucketListInputChanged():
          case BucketListAddRequested():
          case BucketListFilterSelected():
          case BucketListCompletionToggled():
          case BucketListCompletedExpandedChanged():
          case BucketListNotificationsRequested():
            viewModel.onAction(action);
        }
      },
    );
  }

  Future<void> _showNotifications() async {
    if (!mounted) return;
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
  }
}
