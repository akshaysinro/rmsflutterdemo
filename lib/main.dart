import 'package:flutter/material.dart';
import 'package:flutter_rms/common/home.dart';
import 'package:flutter_rms/features/kitchen/view/ingredients/ingredients_details_page.dart';
import 'package:flutter_rms/features/kitchen/view/ingredients/ingredients_list_page.dart';
import 'package:flutter_rms/features/kitchen/view/kitchen_dashboard_view.dart';
import 'package:flutter_rms/features/kitchen/view/recipie_page.dart';
import 'package:flutter_rms/features/kitchen/view/recipie_view_page.dart';
import 'package:flutter_rms/features/outlet/domain/Hotel.dart';
import 'package:flutter_rms/features/outlet/domain/Outlet.dart';
import 'package:flutter_rms/features/outlet/domain/Recipe.dart';
import 'package:flutter_rms/features/pos/pos_home_page.dart';
import 'package:flutter_rms/features/kitchen/presenter/kot_presenter.dart';
import 'package:flutter_rms/features/kitchen/presenter/recipe_presenter.dart';
import 'package:flutter_rms/features/kitchen/presenter/ingredient_presenter.dart';

import 'package:flutter_rms/common/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F&B Enterprise Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      // PATH 1: The Initial Route (Home)
      home: const HomePage(),

      // PATH 2: Defined Routes (For later use)
      routes: {
        '/hotel-setup': (context) => const HotelSetupPage(),
        '/outlet-setup': (context) => const OutletSetupPage(),
        '/recepie-setup': (context) => const RecipeSetupPage(),
        '/pos': (context) => const PosHomePage(),
        '/kitchen': (context) =>
            KitchenDashboardPage(presenter: getIt<KotPresenter>()),
        '/recipie': (context) =>
            RecipeListingPage(presenter: getIt<RecipePresenter>()),
        '/recipieViewPage': (context) => const RecipeViewPage(),
        '/ingredientsListingPage': (context) =>
            IngredientListingPage(presenter: getIt<IngredientPresenter>()),
        '/ingredientsDetailsPage': (context) =>
            const IngredientDetailPage(ingredientId: ''),
      },
    );
  }
}
