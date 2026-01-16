import 'package:flutter/material.dart';
import 'package:flutter_rms/features/kitchen/interactor/kot_interactor.dart';
import 'package:flutter_rms/features/kitchen/router/kot_router.dart';
import 'package:injectable/injectable.dart';

@injectable
class KotPresenter {
  final KotRouter router;
  final KotInteractor interactor;

  KotPresenter({required this.router, required this.interactor});

  void onRecipeBookPressed(BuildContext context) {
    router.navigateToRecipeBook(context);
  }

  void onRecipeDetailsPressed(BuildContext context) {
    router.navigateToRecipeDetails(context);
  }

  void onBackPressed(BuildContext context) {
    router.goBack(context);
  }

  void onLoadKots() {
    interactor.executeGetKots();
  }
}
