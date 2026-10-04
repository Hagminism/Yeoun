import 'package:freezed_annotation/freezed_annotation.dart';

part 'culture_event.freezed.dart';

@Freezed(equal: false)
sealed class CultureEvent with _$CultureEvent {
  const factory CultureEvent.navigateBack() = CultureNavigateBack;
  const factory CultureEvent.pickArtwork() = CulturePickArtwork;
}
