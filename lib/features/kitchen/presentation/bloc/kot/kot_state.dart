import 'package:freezed_annotation/freezed_annotation.dart';

part 'kot_state.freezed.dart';

@freezed
class KotState with _$KotState {
  const factory KotState.initial() = _Initial;
  const factory KotState.loading() = _Loading;
  const factory KotState.loadSuccess({required dynamic kots}) = _LoadSuccess;
  const factory KotState.loadFailure({required String message}) = _LoadFailure;
}
