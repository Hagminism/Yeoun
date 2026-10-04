import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/bucket_list_category.dart';

part 'bucket_list_action.freezed.dart';

@freezed
sealed class BucketListAction with _$BucketListAction {
  const factory BucketListAction.inputChanged(String value) =
      BucketListInputChanged;
  const factory BucketListAction.addRequested() = BucketListAddRequested;
  const factory BucketListAction.filterSelected(BucketListCategory category) =
      BucketListFilterSelected;
  const factory BucketListAction.completionToggled(String id) =
      BucketListCompletionToggled;
  const factory BucketListAction.completedExpandedChanged(bool expanded) =
      BucketListCompletedExpandedChanged;
  const factory BucketListAction.focusInputRequested() =
      BucketListFocusInputRequested;
  const factory BucketListAction.notificationsRequested() =
      BucketListNotificationsRequested;
  const factory BucketListAction.navigationSelected(int index) =
      BucketListNavigationSelected;
}
