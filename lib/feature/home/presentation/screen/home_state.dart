import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/domain/model/bucket/bucket_item.dart';
import '../../../../core/domain/model/capsule/time_capsule.dart';
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
    required Anniversary anniversary,
    required TimeCapsule capsule,
  }) = _HomeState;
}
