import 'package:flutter/material.dart';
import 'package:flutter_rms/features/kitchen/interactor/recipe_interactor.dart';
import 'package:flutter_rms/features/kitchen/router/recipe_router.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecipePresenter {
  final RecipeRouter router;
  final RecipeInteractor interactor;

  RecipePresenter({required this.router, required this.interactor});

  void onRecipeDetailsPressed(BuildContext context) {
    router.navigateToRecipeDetails(context);
  }

  void onIngridientsPressed(BuildContext context) {
    router.navigateToIngredietsListing(context);
  }

  void onBackPressed(BuildContext context) {
    router.goBack(context);
  }

  // Add recipe-specific load logic if needed
}
