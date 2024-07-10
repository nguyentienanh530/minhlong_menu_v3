// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TableItemImpl _$$TableItemImplFromJson(Map<String, dynamic> json) =>
    _$TableItemImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      seats: (json['seats'] as num?)?.toInt() ?? 0,
      isUse: json['is_use'] as bool? ?? false,
      orderCount: (json['order_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TableItemImplToJson(_$TableItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seats': instance.seats,
      'is_use': instance.isUse,
      'order_count': instance.orderCount,
    };
