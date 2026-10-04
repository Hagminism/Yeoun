import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/bucket_list_category.dart';

part 'bucket_list_state.freezed.dart';

@freezed
abstract class BucketListState with _$BucketListState {
  const factory BucketListState({
    @Default(BucketListCategory.all) BucketListCategory selectedCategory,
    @Default('') String inputText,
    @Default(true) bool completedExpanded,
  }) = _BucketListState;

  const BucketListState._();
}
