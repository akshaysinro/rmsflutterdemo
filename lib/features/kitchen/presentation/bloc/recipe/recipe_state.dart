import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_state.freezed.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState.initial() = _Initial;
  const factory RecipeState.loading() = _Loading;
  const factory RecipeState.loadSuccess() = _LoadSuccess;
}
