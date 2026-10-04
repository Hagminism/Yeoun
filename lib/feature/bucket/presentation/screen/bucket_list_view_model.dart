import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/bucket_list_category.dart';
import 'bucket_list_action.dart';
import 'bucket_list_event.dart';
import 'bucket_list_state.dart';

class BucketListViewModel extends Notifier<BucketListState> {
  final StreamController<BucketListEvent> _events =
      StreamController<BucketListEvent>.broadcast();

  Stream<BucketListEvent> get eventStream => _events.stream;

  @override
  BucketListState build() {
    ref.onDispose(_events.close);
    return const BucketListState();
  }

  void onAction(BucketListAction action) {
    switch (action) {
      case BucketListInputChanged(:final value):
        state = state.copyWith(inputText: value);
      case BucketListAddRequested():
        _requestAddEntry();
      case BucketListFilterSelected(:final category):
        state = state.copyWith(selectedCategory: category);
      case BucketListCompletionToggled(:final id):
        _events.add(BucketListEvent.toggleBucket(id));
      case BucketListCompletedExpandedChanged(:final expanded):
        state = state.copyWith(completedExpanded: expanded);
      case BucketListNotificationsRequested():
        _events.add(const BucketListEvent.showNotifications());
      case BucketListFocusInputRequested():
      case BucketListNavigationSelected():
        break;
    }
  }

  void _requestAddEntry() {
    final title = state.inputText.trim();
    if (title.isEmpty) return;

    _events.add(BucketListEvent.addBucket(title));
    state = state.copyWith(
      inputText: '',
      selectedCategory: BucketListCategory.all,
    );
  }
}

final bucketListViewModelProvider =
    NotifierProvider<BucketListViewModel, BucketListState>(
      BucketListViewModel.new,
    );
