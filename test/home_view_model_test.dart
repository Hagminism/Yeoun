import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yeoun/core/domain/model/bucket/bucket_item.dart';
import 'package:yeoun/feature/general_record/presentation/screen/general_record_action.dart';
import 'package:yeoun/feature/general_record/presentation/screen/general_record_view_model.dart';
import 'package:yeoun/feature/home/presentation/screen/home_view_model.dart';
import 'package:yeoun/feature/home/presentation/screen/home_action.dart';
import 'package:yeoun/feature/home/presentation/screen/home_event.dart';

void main() {
  test('Widget order, visibility and local edits remain consistent', () {
    final container = ProviderContainer();
    final subscription = container.listen(homeViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    addTearDown(container.dispose);
    final viewModel = container.read(homeViewModelProvider.notifier);
    final initial = container.read(homeViewModelProvider);

    final lastPosition = initial.widgetConfigs.length - 1;
    viewModel.onAction(HomeAction.widgetsReordered(0, lastPosition));
    var state = container.read(homeViewModelProvider);
    expect(state.widgetConfigs.last.id, initial.widgetConfigs.first.id);
    expect(
      state.widgetConfigs.map((config) => config.position),
      List<int>.generate(initial.widgetConfigs.length, (int index) => index),
    );
    viewModel.onAction(
      const HomeAction.widgetVisibilityChanged('anniversary', false),
    );
    expect(
      container.read(homeViewModelProvider).widgetConfigs.last.visible,
      false,
    );

    viewModel.onAction(HomeAction.toggleBucket(initial.buckets.first.id));
    expect(
      container.read(homeViewModelProvider).buckets.first.completed,
      false,
    );
    viewModel.onAction(const HomeAction.bucketAdded('  함께 산책하기  '));
    state = container.read(homeViewModelProvider);
    expect(state.buckets.first.title, '함께 산책하기');
    expect(state.buckets.length, initial.buckets.length + 1);
    viewModel.onAction(const HomeAction.bucketAdded('   '));
    expect(container.read(homeViewModelProvider), state);

    viewModel.onAction(const HomeAction.spaceRenamed('우리의 여운'));
    expect(container.read(homeViewModelProvider).spaceTitle, '우리의 여운');
  });

  test('General records are created through their feature state', () {
    final container = ProviderContainer();
    final subscription = container.listen(
      generalRecordViewModelProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    addTearDown(container.dispose);
    final viewModel = container.read(generalRecordViewModelProvider.notifier);

    viewModel.onAction(const GeneralRecordAction.createRequested());
    viewModel.onAction(const GeneralRecordAction.contentChanged('오늘의 순간'));
    viewModel.onAction(const GeneralRecordAction.saveRequested());

    final entries = container.read(generalRecordViewModelProvider).entries;
    expect(entries, hasLength(1));
    expect(entries.single.content, '오늘의 순간');
  });

  test('Repeated commands emit distinct one-shot events', () async {
    final container = ProviderContainer();
    final subscription = container.listen(homeViewModelProvider, (_, _) {});
    addTearDown(subscription.close);
    addTearDown(container.dispose);
    final viewModel = container.read(homeViewModelProvider.notifier);
    final events = <HomeEvent>[];
    final listener = viewModel.eventStream.listen(events.add);
    addTearDown(listener.cancel);
    viewModel.onAction(const HomeAction.addBucketRequested());
    viewModel.onAction(const HomeAction.addBucketRequested());
    await Future<void>.delayed(Duration.zero);
    expect(events, hasLength(2));
    expect(events.first, isA<HomeComposeBucket>());
    expect(events.first == events.last, false);
  });

  test('Domain models support JSON round trips', () {
    const item = BucketItem(id: '1', title: '산책', category: '일상');
    expect(BucketItem.fromJson(item.toJson()), item);
  });
}
