import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_client_v3/features/home/data/repository/home_repo.dart';

import '../data/model/home_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.homeRepo) : super(HomeInitial()) {
    on<HomeFetched>(_onHomeFetched);
  }
  final HomeRepo homeRepo;

  FutureOr<void> _onHomeFetched(
      HomeFetched event, Emitter<HomeState> emit) async {
    emit(HomeFetchInProgress());
    final result = await homeRepo.getHome();
    result.when(
      success: (home) {
        emit(HomeFetchSuccess(homeModel: home));
      },
      failure: (message) {
        emit(HomeFetchFailure(message: message));
      },
    );
  }
}
