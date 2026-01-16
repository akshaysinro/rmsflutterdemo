import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RecipeRouter {
  void navigateToRecipeDetails(BuildContext context) {
    Navigator.pushNamed(context, '/recipieViewPage');
  }

  void navigateToIngredietsListing(BuildContext context) {
    Navigator.pushNamed(context, '/ingredientsListingPage');
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
