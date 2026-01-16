import 'package:flutter/material.dart';
import 'package:flutter_rms/features/kitchen/interactor/ingredient_interactor.dart';
import 'package:flutter_rms/features/kitchen/router/ingredient_router.dart';
import 'package:injectable/injectable.dart';

@injectable
class IngredientPresenter {
  final IngredientRouter router;
  final IngredientInteractor interactor;

  IngredientPresenter({required this.router, required this.interactor});

  void onIngridientsPressed(BuildContext context) {
    router.navigateToIngredietsListing(context);
  }

  void onIngridientsTilePressed(BuildContext context) {
    router.navigateToIngredietsDetails(context);
  }

  void onBackPressed(BuildContext context) {
    router.goBack(context);
  }

  void onLoadIngredients() {
    interactor.executeGetIngredients();
  }
}
