import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/domain/model/bucket/bucket_item.dart';
import '../../data/home_mock_data.dart';
import 'home_action.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    ref.onDispose(_events.close);
    return HomeState(
      anniversary: HomeMockData.anniversary,
      capsule: HomeMockData.capsule,
      buckets: HomeMockData.buckets,
      widgetConfigs: HomeMockData.widgetConfigs,
    );
  }

  final StreamController<HomeEvent> _events =
      StreamController<HomeEvent>.broadcast();

  Stream<HomeEvent> get eventStream => _events.stream;

  void onAction(HomeAction action) {
    switch (action) {
      case HomeDismissBanner():
        state = state.copyWith(bannerVisible: false);
      case HomeToggleBucket(:final id):
        state = state.copyWith(
          buckets: [
            for (final item in state.buckets)
              item.id == id ? item.copyWith(completed: !item.completed) : item,
          ],
        );
      case HomeAddBucketRequested():
        _events.add(HomeEvent.composeBucket());
      case HomeBucketAdded(:final title):
        addBucket(title);
      case HomeEditWidgetsRequested():
        _events.add(HomeEvent.editWidgets());
      case HomeWidgetVisibilityChanged(:final id, :final visible):
        state = state.copyWith(
          widgetConfigs: [
            for (final config in state.widgetConfigs)
              config.id == id ? config.copyWith(visible: visible) : config,
          ],
        );
      case HomeWidgetsReordered(:final from, :final to):
        reorderWidgets(from, to);
      case HomeDetailRequested():
        break;
      case HomeNavigationSelected():
        break;
      case HomeNewRecordRequested():
        _events.add(HomeEvent.chooseRecord());
      case HomeNotificationsRequested():
        _events.add(HomeEvent.showNotifications());
      case HomeSettingsRequested():
        _events.add(HomeEvent.openSettings());
      case HomeSpaceRenamed(:final title):
        if (title.trim().isNotEmpty) {
          state = state.copyWith(spaceTitle: title.trim());
        }
    }
  }

  void addBucket(String title) {
    final value = title.trim();
    if (value.isEmpty) {
      return;
    }
    state = state.copyWith(
      buckets: [
        BucketItem(
          id: 'bucket-${state.buckets.length + 1}',
          title: value,
          category: '✨ 일상',
        ),
        ...state.buckets,
      ],
    );
  }

  void reorderWidgets(int from, int to) {
    final configs = [...state.widgetConfigs];
    if (from < 0 || from >= configs.length || to < 0 || to >= configs.length) {
      return;
    }
    final item = configs.removeAt(from);
    configs.insert(to, item);
    state = state.copyWith(
      widgetConfigs: [
        for (var index = 0; index < configs.length; index++)
          configs[index].copyWith(position: index),
      ],
    );
  }
}

final homeViewModelProvider =
    NotifierProvider.autoDispose<HomeViewModel, HomeState>(HomeViewModel.new);
