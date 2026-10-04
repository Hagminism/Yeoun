import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_event.freezed.dart';

@Freezed(equal: false)
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.navigateHome() = HomeNavigateHome;
  const factory HomeEvent.composeBucket() = HomeComposeBucket;
  const factory HomeEvent.editWidgets() = HomeEditWidgets;
  const factory HomeEvent.chooseRecord() = HomeChooseRecord;
  const factory HomeEvent.showNotifications() = HomeShowNotifications;
  const factory HomeEvent.openSettings() = HomeOpenSettings;
}
