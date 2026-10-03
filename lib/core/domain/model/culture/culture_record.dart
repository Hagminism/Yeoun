import 'package:freezed_annotation/freezed_annotation.dart';

part 'culture_record.freezed.dart';
part 'culture_record.g.dart';

@freezed
abstract class CultureRecord with _$CultureRecord {
  const factory CultureRecord({
    required String title,
    required double rating,
    required String review,
    required String posterAsset,
  }) = _CultureRecord;

  factory CultureRecord.fromJson(Map<String, dynamic> json) =>
      _$CultureRecordFromJson(json);
}
