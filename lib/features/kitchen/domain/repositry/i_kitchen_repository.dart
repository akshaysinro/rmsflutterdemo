import 'package:dartz/dartz.dart';
import 'package:flutter_rms/common/error/errors.dart';
import 'package:flutter_rms/features/kitchen/data/ingredient_model.dart';

abstract class IKotRepository {
  Future<Either<MainFailure, dynamic>> fetchKots();
}

abstract class IRecipeRepository {
  // Add recipe specific methods here if needed,
  // currently the GOD repo didn't have specific ones but it's good to have the interface.
}

abstract class IIngredientRepository {
  Future<Either<MainFailure, List<IngredientModel>>> fetchIngredients();
  Future<Either<MainFailure, dynamic>> deductStock();
}
