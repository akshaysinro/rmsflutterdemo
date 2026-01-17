import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rms/features/kitchen/interactor/ingredient_interactor.dart';
import 'package:flutter_rms/features/kitchen/router/ingredient_router.dart';
import 'package:injectable/injectable.dart';
import 'ingredient_event.dart';
import 'ingredient_state.dart';

@injectable
class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final IngredientInteractor interactor;
  final IngredientRouter router;

  IngredientBloc(this.interactor, this.router)
    : super(const IngredientState.initial()) {
    on<IngredientEvent>((event, emit) async {
      await event.map(
        initialize: (_) async {
          emit(const IngredientState.loading());
          final result = await interactor.executeGetIngredients();
          result.fold(
            (failure) =>
                emit(IngredientState.loadFailure(message: failure.toString())),
            (ingredients) {
              print("Success **************");
                emit(IngredientState.loadSuccess(ingredients: ingredients));

            }
          );
        },
      );
    });
  }
}
