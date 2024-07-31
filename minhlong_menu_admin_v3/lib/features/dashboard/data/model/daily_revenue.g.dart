// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_revenue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyRevenueImpl _$$DailyRevenueImplFromJson(Map<String, dynamic> json) =>
    _$DailyRevenueImpl(
      date: json['date'] as String? ?? '',
      revenue: (json['total_price'] as num?)?.toDouble() ?? 0.0,
      orderCount: (json['order_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DailyRevenueImplToJson(_$DailyRevenueImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'total_price': instance.revenue,
      'order_count': instance.orderCount,
    };
