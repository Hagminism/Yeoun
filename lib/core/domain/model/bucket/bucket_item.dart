import 'package:freezed_annotation/freezed_annotation.dart';

part 'bucket_item.freezed.dart';
part 'bucket_item.g.dart';

@freezed
abstract class BucketItem with _$BucketItem {
  const factory BucketItem({
    required String id,
    required String title,
    required String category,
    @Default(false) bool completed,
  }) = _BucketItem;

  factory BucketItem.fromJson(Map<String, dynamic> json) =>
      _$BucketItemFromJson(json);
}
