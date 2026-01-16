import 'package:flutter_rms/features/kitchen/domain/repositry/i_kitchen_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class IngredientInteractor {
  final IIngredientRepository ingredientRepository;

  IngredientInteractor({required this.ingredientRepository});

  Future executeGetIngredients() async {
    return await ingredientRepository.fetchIngredients();
  }

  Future executeDeductStock() async {
    return await ingredientRepository.deductStock();
  }
}
