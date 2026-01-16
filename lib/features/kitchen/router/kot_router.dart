import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class KotRouter {
  void navigateToRecipeBook(BuildContext context) {
    Navigator.pushNamed(context, '/recipie');
  }

  void navigateToRecipeDetails(BuildContext context) {
    Navigator.pushNamed(context, '/recipieViewPage');
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
