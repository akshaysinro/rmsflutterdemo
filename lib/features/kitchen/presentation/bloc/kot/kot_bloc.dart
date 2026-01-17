import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rms/features/kitchen/interactor/kot_interactor.dart';
import 'package:flutter_rms/features/kitchen/router/kot_router.dart';
import 'package:injectable/injectable.dart';
import 'kot_event.dart';
import 'kot_state.dart';

@injectable
class KotBloc extends Bloc<KotEvent, KotState> {
  final KotInteractor interactor;
  final KotRouter router;

  KotBloc(this.interactor, this.router) : super(const KotState.initial()) {
    on<KotEvent>((event, emit) async {
      await event.map(
        initialize: (_) async {
          emit(const KotState.loading());
          final result = await interactor.executeGetKots();
          result.fold(
            (failure) =>
                emit(KotState.loadFailure(message: failure.toString())),
            (kots) => emit(KotState.loadSuccess(kots: kots)),
          );
        },
        refreshKots: (_) async {
          emit(const KotState.loading());
          final result = await interactor.executeGetKots();
          result.fold(
            (failure) =>
                emit(KotState.loadFailure(message: failure.toString())),
            (kots) => emit(KotState.loadSuccess(kots: kots)),
          );
        },
      );
    });
  }
}
