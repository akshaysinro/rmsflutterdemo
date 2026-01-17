import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rms/features/kitchen/interactor/recipe_interactor.dart';
import 'package:flutter_rms/features/kitchen/router/recipe_router.dart';
import 'package:injectable/injectable.dart';
import 'recipe_event.dart';
import 'recipe_state.dart';

@injectable
class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeInteractor interactor;
  final RecipeRouter router;

  RecipeBloc(this.interactor, this.router)
    : super(const RecipeState.initial()) {
    on<RecipeEvent>((event, emit) async {
      await event.map(
        initialize: (_) async {
          // Logic for recipe initialization if needed
        },
      );
    });
  }
}
