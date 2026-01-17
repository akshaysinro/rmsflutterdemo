import 'package:freezed_annotation/freezed_annotation.dart';

part 'kot_event.freezed.dart';

@freezed
class KotEvent with _$KotEvent {
  const factory KotEvent.initialize() = _Initialize;
  const factory KotEvent.refreshKots() = _RefreshKots;
}
