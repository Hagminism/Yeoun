import 'package:freezed_annotation/freezed_annotation.dart';

part 'anniversary.freezed.dart';
part 'anniversary.g.dart';

@freezed
abstract class Anniversary with _$Anniversary {
  const factory Anniversary({
    required String startLabel,
    required int daysTogether,
    required String targetLabel,
    required int remainingDays,
    required double progress,
  }) = _Anniversary;

  factory Anniversary.fromJson(Map<String, dynamic> json) =>
      _$AnniversaryFromJson(json);
}
