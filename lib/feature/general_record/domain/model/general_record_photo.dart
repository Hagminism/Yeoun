import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_record_photo.freezed.dart';
part 'general_record_photo.g.dart';

@freezed
abstract class GeneralRecordPhoto with _$GeneralRecordPhoto {
  const factory GeneralRecordPhoto({
    required String id,
    required String fileName,
    @Default(<int>[]) List<int> bytes,
  }) = _GeneralRecordPhoto;

  factory GeneralRecordPhoto.fromJson(Map<String, dynamic> json) =>
      _$GeneralRecordPhotoFromJson(json);
}
