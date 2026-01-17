// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_rms/common/network/api_client.dart' as _i871;
import 'package:flutter_rms/common/network/dio_client.dart' as _i119;
import 'package:flutter_rms/features/kitchen/domain/repositry/i_kitchen_repository.dart'
    as _i316;
import 'package:flutter_rms/features/kitchen/interactor/ingredient_interactor.dart'
    as _i514;
import 'package:flutter_rms/features/kitchen/interactor/kot_interactor.dart'
    as _i300;
import 'package:flutter_rms/features/kitchen/interactor/recipe_interactor.dart'
    as _i328;
import 'package:flutter_rms/features/kitchen/interactor/repository/ingredient_repository.dart'
    as _i117;
import 'package:flutter_rms/features/kitchen/interactor/repository/kot_repository.dart'
    as _i696;
import 'package:flutter_rms/features/kitchen/interactor/repository/recipe_repository.dart'
    as _i728;
import 'package:flutter_rms/features/kitchen/presentation/bloc/ingredient/ingredient_bloc.dart'
    as _i832;
import 'package:flutter_rms/features/kitchen/presentation/bloc/kot/kot_bloc.dart'
    as _i1026;
import 'package:flutter_rms/features/kitchen/presentation/bloc/recipe/recipe_bloc.dart'
    as _i573;
import 'package:flutter_rms/features/kitchen/router/ingredient_router.dart'
    as _i57;
import 'package:flutter_rms/features/kitchen/router/kot_router.dart' as _i583;
import 'package:flutter_rms/features/kitchen/router/recipe_router.dart'
    as _i551;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i57.IngredientRouter>(() => _i57.IngredientRouter());
    gh.lazySingleton<_i583.KotRouter>(() => _i583.KotRouter());
    gh.lazySingleton<_i551.RecipeRouter>(() => _i551.RecipeRouter());
    gh.lazySingleton<_i871.IApiClient>(() => _i119.DioApiClient());
    gh.lazySingleton<_i316.IKotRepository>(
      () => _i696.KotRepository(apiClient: gh<_i871.IApiClient>()),
    );
    gh.lazySingleton<_i316.IRecipeRepository>(
      () => _i728.RecipeRepository(apiClient: gh<_i871.IApiClient>()),
    );
    gh.lazySingleton<_i316.IIngredientRepository>(
      () => _i117.IngredientRepository(apiClient: gh<_i871.IApiClient>()),
    );
    gh.factory<_i300.KotInteractor>(
      () => _i300.KotInteractor(kotRepository: gh<_i316.IKotRepository>()),
    );
    gh.factory<_i514.IngredientInteractor>(
      () => _i514.IngredientInteractor(
        ingredientRepository: gh<_i316.IIngredientRepository>(),
      ),
    );
    gh.factory<_i328.RecipeInteractor>(
      () => _i328.RecipeInteractor(
        recipeRepository: gh<_i316.IRecipeRepository>(),
      ),
    );
    gh.factory<_i573.RecipeBloc>(
      () => _i573.RecipeBloc(
        gh<_i328.RecipeInteractor>(),
        gh<_i551.RecipeRouter>(),
      ),
    );
    gh.factory<_i832.IngredientBloc>(
      () => _i832.IngredientBloc(
        gh<_i514.IngredientInteractor>(),
        gh<_i57.IngredientRouter>(),
      ),
    );
    gh.factory<_i1026.KotBloc>(
      () => _i1026.KotBloc(gh<_i300.KotInteractor>(), gh<_i583.KotRouter>()),
    );
    return this;
  }
}
