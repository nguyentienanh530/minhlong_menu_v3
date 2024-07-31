import 'package:freezed_annotation/freezed_annotation.dart';
part 'daily_revenue.freezed.dart';
part 'daily_revenue.g.dart';

@freezed
class DailyRevenue with _$DailyRevenue {
  const factory DailyRevenue({
    @Default('') String date,
    @Default(0.0) @JsonKey(name: 'total_price') double revenue,
    @Default(0) @JsonKey(name: 'order_count') int orderCount,
  }) = _DailyRevenue;

  factory DailyRevenue.fromJson(Map<String, dynamic> json) =>
      _$DailyRevenueFromJson(json);
}
