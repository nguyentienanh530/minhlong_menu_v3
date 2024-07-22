import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/respositories/info_respository.dart';

import '../../data/model/data_chart.dart';

part 'data_chart_event.dart';
part 'data_chart_state.dart';

typedef Emit = Emitter<DataChartState>;

class DataChartBloc extends Bloc<DataChartEvent, DataChartState> {
  DataChartBloc({required InfoRespository infoRespository})
      : _infoRespository = infoRespository,
        super(DataChartInitial()) {
    on<DataChartFetched>(_onDataChartFetched);
  }

  final InfoRespository _infoRespository;

  FutureOr<void> _onDataChartFetched(DataChartFetched event, Emit emit) async {
    emit(DataChartFetchInProgress());
    final result = await _infoRespository.getDataChart(type: event.type);
    result.when(
      success: (dataChart) {
        emit(DataChartFetchSuccess(dataChart));
      },
      failure: (message) {
        emit(DataChartFetchFailure(message));
      },
    );
  }
}
