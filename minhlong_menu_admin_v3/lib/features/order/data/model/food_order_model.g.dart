// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodOrderModelImpl _$$FoodOrderModelImplFromJson(Map<String, dynamic> json) =>
    _$FoodOrderModelImpl(
      id: (json['order_details_id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      foodID: (json['food_id'] as num?)?.toInt() ?? 0,
      image1: json['image1'] as String?,
      image2: json['image2'] as String?,
      image3: json['image3'] as String?,
      image4: json['image4'] as String?,
      note: json['note'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
      isDiscount: json['is_discount'] as bool? ?? false,
      discount: (json['discount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FoodOrderModelImplToJson(
        _$FoodOrderModelImpl instance) =>
    <String, dynamic>{
      'order_details_id': instance.id,
      'name': instance.name,
      'food_id': instance.foodID,
      'image1': instance.image1,
      'image2': instance.image2,
      'image3': instance.image3,
      'image4': instance.image4,
      'note': instance.note,
      'price': instance.price,
      'quantity': instance.quantity,
      'total_amount': instance.totalAmount,
      'is_discount': instance.isDiscount,
      'discount': instance.discount,
    };
