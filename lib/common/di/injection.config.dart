// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_rms/common/network/api_client.dart.dart' as _i844;
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
import 'package:flutter_rms/features/kitchen/presenter/ingredient_presenter.dart'
    as _i462;
import 'package:flutter_rms/features/kitchen/presenter/kot_presenter.dart'
    as _i738;
import 'package:flutter_rms/features/kitchen/presenter/recipe_presenter.dart'
    as _i517;
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
    gh.lazySingleton<_i316.IKotRepository>(
      () => _i696.KotRepository(apiClient: gh<_i844.IApiClient>()),
    );
    gh.factory<_i300.KotInteractor>(
      () => _i300.KotInteractor(kotRepository: gh<_i316.IKotRepository>()),
    );
    gh.factory<_i738.KotPresenter>(
      () => _i738.KotPresenter(
        router: gh<_i583.KotRouter>(),
        interactor: gh<_i300.KotInteractor>(),
      ),
    );
    gh.lazySingleton<_i316.IRecipeRepository>(
      () => _i728.RecipeRepository(apiClient: gh<_i844.IApiClient>()),
    );
    gh.lazySingleton<_i316.IIngredientRepository>(
      () => _i117.IngredientRepository(apiClient: gh<_i844.IApiClient>()),
    );
    gh.factory<_i328.RecipeInteractor>(
      () => _i328.RecipeInteractor(
        recipeRepository: gh<_i316.IRecipeRepository>(),
      ),
    );
    gh.factory<_i517.RecipePresenter>(
      () => _i517.RecipePresenter(
        router: gh<_i551.RecipeRouter>(),
        interactor: gh<_i328.RecipeInteractor>(),
      ),
    );
    gh.factory<_i514.IngredientInteractor>(
      () => _i514.IngredientInteractor(
        ingredientRepository: gh<_i316.IIngredientRepository>(),
      ),
    );
    gh.factory<_i462.IngredientPresenter>(
      () => _i462.IngredientPresenter(
        router: gh<_i57.IngredientRouter>(),
        interactor: gh<_i514.IngredientInteractor>(),
      ),
    );
    return this;
  }
}
