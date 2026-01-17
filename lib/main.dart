import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rms/common/home.dart';
import 'package:flutter_rms/features/kitchen/presentation/bloc/kot/kot_bloc.dart';
import 'package:flutter_rms/features/kitchen/presentation/bloc/recipe/recipe_bloc.dart';
import 'package:flutter_rms/features/kitchen/presentation/bloc/ingredient/ingredient_bloc.dart';
import 'package:flutter_rms/features/kitchen/view/ingredients/ingredients_details_page.dart';
import 'package:flutter_rms/features/kitchen/view/ingredients/ingredients_list_page.dart';
import 'package:flutter_rms/features/kitchen/view/kitchen_dashboard_view.dart';
import 'package:flutter_rms/features/kitchen/view/recipie_page.dart';
import 'package:flutter_rms/features/kitchen/view/recipie_view_page.dart';
import 'package:flutter_rms/features/outlet/domain/Hotel.dart';
import 'package:flutter_rms/features/outlet/domain/Outlet.dart';
import 'package:flutter_rms/features/outlet/domain/Recipe.dart';
import 'package:flutter_rms/features/pos/pos_home_page.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<KotBloc>()),
        BlocProvider(create: (context) => getIt<RecipeBloc>()),
        BlocProvider(create: (context) => getIt<IngredientBloc>()),
      ],
      child: MaterialApp(
        title: 'F&B Enterprise Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const HomePage(),
        routes: {
          '/hotel-setup': (context) => const HotelSetupPage(),
          '/outlet-setup': (context) => const OutletSetupPage(),
          '/recepie-setup': (context) => const RecipeSetupPage(),
          '/pos': (context) => const PosHomePage(),
          '/kitchen': (context) => const KitchenDashboardPage(),
          '/recipie': (context) => const RecipeListingPage(),
          '/recipieViewPage': (context) => const RecipeViewPage(),
          '/ingredientsListingPage': (context) => const IngredientListingPage(),
          '/ingredientsDetailsPage': (context) =>
              const IngredientDetailPage(ingredientId: ''),
        },
      ),
    );
  }
}
