import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yeoun/core/domain/model/bucket/bucket_item.dart';
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

    viewModel.onAction(const HomeAction.widgetsReordered(0, 5));
    var state = container.read(homeViewModelProvider);
    expect(state.widgetConfigs.last.id, initial.widgetConfigs.first.id);
    expect(state.widgetConfigs.map((config) => config.position), [
      0,
      1,
      2,
      3,
      4,
      5,
    ]);
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

    viewModel.onAction(const HomeAction.memoSaved('오늘의 순간'));
    expect(container.read(homeViewModelProvider).memo.content, '오늘의 순간');
    expect(
      container.read(homeViewModelProvider).memoCount,
      initial.memoCount + 1,
    );
    viewModel.onAction(const HomeAction.spaceRenamed('우리의 여운'));
    expect(container.read(homeViewModelProvider).spaceTitle, '우리의 여운');
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
