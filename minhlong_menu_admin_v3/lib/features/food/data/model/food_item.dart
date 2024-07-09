import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'food_item.freezed.dart';
part 'food_item.g.dart';

List<dynamic>? stringToList(String? photoGallery) {
  return photoGallery != null && photoGallery.isNotEmpty
      ? json.decode(photoGallery).cast<String>().toList()
      : [];
}

@freezed
class FoodItem with _$FoodItem {
  factory FoodItem({
    @Default(0) int id,
    @Default('') String name,
    @Default(0) @JsonKey(name: 'category_id') int categoryID,
    @Default(0) @JsonKey(name: 'order_count') int orderCount,
    @Default('') String description,
    @Default(0) int? discount,
    @Default(false) @JsonKey(name: 'is_discount') bool? isDiscount,
    @Default(true) @JsonKey(name: 'is_show') bool? isShow,
    @Default(0) double? price,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    final String? image1,
    final String? image2,
    final String? image3,
    final String? image4,
    @Default('') @JsonKey(name: 'category_name') String categoryName,
  }) = _FoodItem;

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
}
