// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? '',
      tableId: (json['table_id'] as num?)?.toInt() ?? 0,
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0,
      payedAt: json['payed_at'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      foodOrders: (json['foods'] as List<dynamic>?)
              ?.map((e) => FoodOrderModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FoodOrderModel>[],
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'table_id': instance.tableId,
      'total_price': instance.totalPrice,
      'payed_at': instance.payedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'foods': instance.foodOrders,
    };
