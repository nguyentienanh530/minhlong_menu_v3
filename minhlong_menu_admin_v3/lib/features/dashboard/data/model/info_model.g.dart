// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InfoModelImpl _$$InfoModelImplFromJson(Map<String, dynamic> json) =>
    _$InfoModelImpl(
      categoryCount: (json['category_count'] as num?)?.toInt() ?? 0,
      orderCount: (json['order_count'] as num?)?.toInt() ?? 0,
      foodCount: (json['food_count'] as num?)?.toInt() ?? 0,
      tableCount: (json['table_count'] as num?)?.toInt() ?? 0,
      revenueToday: (json['revenue_on_today'] as num?)?.toDouble() ?? 0,
      revenueOnYesterday:
          (json['revenue_on_yesterday'] as num?)?.toDouble() ?? 0,
      totalRevenue: (json['total_revenue'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$InfoModelImplToJson(_$InfoModelImpl instance) =>
    <String, dynamic>{
      'category_count': instance.categoryCount,
      'order_count': instance.orderCount,
      'food_count': instance.foodCount,
      'table_count': instance.tableCount,
      'revenue_on_today': instance.revenueToday,
      'revenue_on_yesterday': instance.revenueOnYesterday,
      'total_revenue': instance.totalRevenue,
    };
