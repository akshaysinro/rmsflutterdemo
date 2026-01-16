import 'package:flutter_rms/features/kitchen/domain/repositry/i_kitchen_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecipeInteractor {
  final IRecipeRepository recipeRepository;

  RecipeInteractor({required this.recipeRepository});

  // Add recipe specific logic here
}
