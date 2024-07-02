// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodOrderModelImpl _$$FoodOrderModelImplFromJson(Map<String, dynamic> json) =>
    _$FoodOrderModelImpl(
      name: json['name'] as String? ?? '',
      photoGallery: json['photo_gallery'] == null
          ? const []
          : stringToList(json['photo_gallery'] as String),
      note: json['note'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$FoodOrderModelImplToJson(
        _$FoodOrderModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'photo_gallery': instance.photoGallery,
      'note': instance.note,
      'price': instance.price,
      'quantity': instance.quantity,
      'total_amount': instance.totalAmount,
    };
