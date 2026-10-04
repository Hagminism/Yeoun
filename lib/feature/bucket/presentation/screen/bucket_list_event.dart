import 'package:freezed_annotation/freezed_annotation.dart';

part 'bucket_list_event.freezed.dart';

@Freezed(equal: false)
sealed class BucketListEvent with _$BucketListEvent {
  const factory BucketListEvent.addBucket(String title) = BucketListAddBucket;
  const factory BucketListEvent.toggleBucket(String id) =
      BucketListToggleBucket;
  const factory BucketListEvent.showNotifications() =
      BucketListShowNotifications;
}
