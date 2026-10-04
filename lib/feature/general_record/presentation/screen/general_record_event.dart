import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_record_event.freezed.dart';

@Freezed(equal: false)
sealed class GeneralRecordEvent with _$GeneralRecordEvent {
  const factory GeneralRecordEvent.selectPhotos(int remaining) =
      GeneralRecordSelectPhotos;
}
