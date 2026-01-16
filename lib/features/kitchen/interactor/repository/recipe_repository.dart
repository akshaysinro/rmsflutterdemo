import 'package:flutter_rms/common/network/api_client.dart.dart';
import 'package:flutter_rms/features/kitchen/domain/repositry/i_kitchen_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IRecipeRepository)
class RecipeRepository implements IRecipeRepository {
  final IApiClient apiClient;

  RecipeRepository({required this.apiClient});
}
