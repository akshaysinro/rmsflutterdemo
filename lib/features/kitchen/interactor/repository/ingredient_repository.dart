import 'package:dartz/dartz.dart';
import 'package:flutter_rms/common/error/errors.dart';
import 'package:flutter_rms/common/network/api_client.dart';
import 'package:flutter_rms/common/network/api_response_handler.dart';
import 'package:flutter_rms/common/network/urls.dart';
import 'package:flutter_rms/features/kitchen/data/ingredient_model.dart';
import 'package:flutter_rms/features/kitchen/domain/repositry/i_kitchen_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IIngredientRepository)
class IngredientRepository implements IIngredientRepository {
  final IApiClient apiClient;

  IngredientRepository({required this.apiClient});

  @override
  Future<Either<MainFailure, List<IngredientModel>>> fetchIngredients() async {
    var response= await ApiResponseHandler.handle(
      () => apiClient.get(Urls.getIngredients),
    );
    response.fold((l) =>  MainFailure(), (r) {
      return ingredientModelFromJson(r);
    },);

    throw MainFailure();
  }

  @override
  Future<Either<MainFailure, dynamic>> deductStock() async {
    throw UnimplementedError();
  }
}
