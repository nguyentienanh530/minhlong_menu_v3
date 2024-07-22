part of 'data_chart_bloc.dart';

@immutable
sealed class DataChartState {}

final class DataChartInitial extends DataChartState {}

final class DataChartFetchInProgress extends DataChartState {}

final class DataChartFetchSuccess extends DataChartState {
  final List<DataChart> dataCharts;
  DataChartFetchSuccess(this.dataCharts);
}

final class DataChartFetchFailure extends DataChartState {
  final String message;
  DataChartFetchFailure(this.message);
}

final class DataChartFetchEmpty extends DataChartState {}
