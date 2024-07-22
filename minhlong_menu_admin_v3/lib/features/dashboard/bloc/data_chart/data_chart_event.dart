part of 'data_chart_bloc.dart';

@immutable
sealed class DataChartEvent {}

final class DataChartFetched extends DataChartEvent {
  final String type;
  DataChartFetched(this.type);
}
