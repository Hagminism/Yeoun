import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/domain/model/space/space_widget_type.dart';
part 'home_action.freezed.dart';

@freezed
sealed class HomeAction with _$HomeAction {
  const factory HomeAction.dismissBanner() = HomeDismissBanner;
  const factory HomeAction.toggleBucket(String id) = HomeToggleBucket;
  const factory HomeAction.addBucketRequested() = HomeAddBucketRequested;
  const factory HomeAction.bucketAdded(String title) = HomeBucketAdded;
  const factory HomeAction.memoRequested() = HomeMemoRequested;
  const factory HomeAction.memoSaved(String content) = HomeMemoSaved;
  const factory HomeAction.editWidgetsRequested() = HomeEditWidgetsRequested;
  const factory HomeAction.widgetVisibilityChanged(String id, bool visible) =
      HomeWidgetVisibilityChanged;
  const factory HomeAction.widgetsReordered(int from, int to) =
      HomeWidgetsReordered;
  const factory HomeAction.detailRequested(SpaceWidgetType type) =
      HomeDetailRequested;
  const factory HomeAction.navigationSelected(int index) =
      HomeNavigationSelected;
  const factory HomeAction.newRecordRequested() = HomeNewRecordRequested;
  const factory HomeAction.notificationsRequested() =
      HomeNotificationsRequested;
  const factory HomeAction.settingsRequested() = HomeSettingsRequested;
  const factory HomeAction.spaceRenamed(String title) = HomeSpaceRenamed;
}
