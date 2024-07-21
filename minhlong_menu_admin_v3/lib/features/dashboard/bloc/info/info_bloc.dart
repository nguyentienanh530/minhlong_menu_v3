import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/respositories/info_respository.dart';

import '../../data/model/info_model.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc(this.infoRespository) : super(InfoInitial()) {
    on<InfoFetchStarted>(_onInfoFetchStarted);
  }

  final InfoRespository infoRespository;

  FutureOr<void> _onInfoFetchStarted(
      InfoFetchStarted event, Emitter<InfoState> emit) async {
    emit(InfoFetchInProgress());
    var result = await infoRespository.getInfo();

    result.when(
      success: (info) {
        emit(InfoFetchSuccess(info));
      },
      failure: (message) {
        emit(InfoFetchFailure(message));
      },
    );
  }
}
