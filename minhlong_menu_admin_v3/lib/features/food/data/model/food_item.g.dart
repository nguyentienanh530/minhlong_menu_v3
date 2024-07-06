// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodItemImpl _$$FoodItemImplFromJson(Map<String, dynamic> json) =>
    _$FoodItemImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      categoryID: (json['category_id'] as num?)?.toInt() ?? 0,
      orderCount: (json['order_count'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? '',
      discount: (json['discount'] as num?)?.toInt() ?? 0,
      isDiscount: json['isDiscount'] as bool? ?? false,
      isShow: json['isShow'] as bool? ?? true,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      photoGallery: json['photo_gallery'] == null
          ? const <String>[]
          : stringToList(json['photo_gallery'] as String),
    );

Map<String, dynamic> _$$FoodItemImplToJson(_$FoodItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category_id': instance.categoryID,
      'order_count': instance.orderCount,
      'description': instance.description,
      'discount': instance.discount,
      'isDiscount': instance.isDiscount,
      'isShow': instance.isShow,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'photo_gallery': instance.photoGallery,
    };
