import 'package:freezed_annotation/freezed_annotation.dart';

import 'bucket_list_category.dart';

part 'bucket_list_entry.freezed.dart';
part 'bucket_list_entry.g.dart';

@freezed
abstract class BucketListEntry with _$BucketListEntry {
  const factory BucketListEntry({
    required String id,
    required String title,
    required BucketListCategory category,
    @Default(false) bool completed,
    @Default('') String description,
    @Default('방금 전') String createdLabel,
    String? dueLabel,
    String? note,
    String? noteIcon,
    double? progress,
    String? progressLabel,
    String? completedAt,
  }) = _BucketListEntry;

  factory BucketListEntry.fromJson(Map<String, dynamic> json) =>
      _$BucketListEntryFromJson(json);
}
