// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_selling_food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BestSellingFoodImpl _$$BestSellingFoodImplFromJson(
        Map<String, dynamic> json) =>
    _$BestSellingFoodImpl(
      orderCount: (json['order_count'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$$BestSellingFoodImplToJson(
        _$BestSellingFoodImpl instance) =>
    <String, dynamic>{
      'order_count': instance.orderCount,
      'name': instance.name,
    };
