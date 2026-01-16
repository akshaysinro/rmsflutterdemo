import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IngredientRouter {
  void navigateToIngredietsListing(BuildContext context) {
    Navigator.pushNamed(context, '/ingredientsListingPage');
  }

  void navigateToIngredietsDetails(BuildContext context) {
    Navigator.pushNamed(context, '/ingredientsDetailsPage');
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
