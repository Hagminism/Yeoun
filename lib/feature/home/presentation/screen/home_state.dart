import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/domain/model/bucket/bucket_item.dart';
import '../../../../core/domain/model/capsule/time_capsule.dart';
import '../../../../core/domain/model/culture/culture_record.dart';
import '../../../../core/domain/model/memory/memory_entry.dart';
import '../../../../core/domain/model/memory/memo_entry.dart';
import '../../../../core/domain/model/space/anniversary.dart';
import '../../../../core/domain/model/space/space_widget_config.dart';
part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default('우리 둘만의 공간') String spaceTitle,
    @Default(true) bool bannerVisible,
    @Default([]) List<SpaceWidgetConfig> widgetConfigs,
    @Default([]) List<BucketItem> buckets,
    @Default([]) List<MemoryEntry> memories,
    required Anniversary anniversary,
    required TimeCapsule capsule,
    required MemoEntry memo,
    required CultureRecord culture,
    @Default(12) int memoCount,
  }) = _HomeState;
}
