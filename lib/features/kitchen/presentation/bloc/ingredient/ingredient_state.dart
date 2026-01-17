import 'package:flutter_rms/features/kitchen/data/ingredient_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_state.freezed.dart';

@freezed
class IngredientState with _$IngredientState {
  const factory IngredientState.initial() = _Initial;
  const factory IngredientState.loading() = _Loading;
  const factory IngredientState.loadSuccess({required List<IngredientModel> ingredients}) =
      _LoadSuccess;
  const factory IngredientState.loadFailure({required String message}) =
      _LoadFailure;
}
