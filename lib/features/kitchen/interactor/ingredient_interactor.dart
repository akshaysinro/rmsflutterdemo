import 'package:dartz/dartz.dart';
import 'package:flutter_rms/common/error/errors.dart';
import 'package:flutter_rms/features/kitchen/data/ingredient_model.dart';
import 'package:flutter_rms/features/kitchen/domain/repositry/i_kitchen_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class IngredientInteractor {
  final IIngredientRepository ingredientRepository;

  IngredientInteractor({required this.ingredientRepository});

  Future<Either<MainFailure, List<IngredientModel>>> executeGetIngredients() async {
    return await ingredientRepository.fetchIngredients();
  }

  Future executeDeductStock() async {
    return await ingredientRepository.deductStock();
  }
}
