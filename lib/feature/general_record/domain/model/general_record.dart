import 'package:freezed_annotation/freezed_annotation.dart';

import 'general_record_photo.dart';

part 'general_record.freezed.dart';
part 'general_record.g.dart';

@freezed
abstract class GeneralRecord with _$GeneralRecord {
  const factory GeneralRecord({
    required String id,
    required String content,
    required DateTime recordedAt,
    @Default(<GeneralRecordPhoto>[]) List<GeneralRecordPhoto> photos,
  }) = _GeneralRecord;

  factory GeneralRecord.fromJson(Map<String, dynamic> json) =>
      _$GeneralRecordFromJson(json);
}
