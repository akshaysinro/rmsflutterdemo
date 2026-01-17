import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_event.freezed.dart';

@freezed
class IngredientEvent with _$IngredientEvent {
  const factory IngredientEvent.initialize() = _Initialize;
}
