import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_capsule.freezed.dart';
part 'time_capsule.g.dart';

@freezed
abstract class TimeCapsule with _$TimeCapsule {
  const factory TimeCapsule({
    required String title,
    required String authors,
    required String openingLabel,
    required int remainingDays,
  }) = _TimeCapsule;

  factory TimeCapsule.fromJson(Map<String, dynamic> json) =>
      _$TimeCapsuleFromJson(json);
}
