import 'package:freezed_annotation/freezed_annotation.dart';
import 'space_widget_type.dart';

part 'space_widget_config.freezed.dart';
part 'space_widget_config.g.dart';

@freezed
abstract class SpaceWidgetConfig with _$SpaceWidgetConfig {
  const factory SpaceWidgetConfig({
    required String id,
    required SpaceWidgetType type,
    required int position,
    @Default(true) bool visible,
  }) = _SpaceWidgetConfig;

  factory SpaceWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$SpaceWidgetConfigFromJson(json);
}
