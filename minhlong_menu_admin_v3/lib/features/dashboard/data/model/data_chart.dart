import 'package:freezed_annotation/freezed_annotation.dart';
part 'data_chart.freezed.dart';
part 'data_chart.g.dart';

@freezed
class DataChart with _$DataChart {
  factory DataChart({
    @Default(0) @JsonKey(name: 'total_price') dynamic totalPrice,
    @Default('') @JsonKey(name: 'date') String date,
  }) = _DataChart;

  factory DataChart.fromJson(Map<String, dynamic> json) =>
      _$DataChartFromJson(json);
}
