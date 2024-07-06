import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'food_item.freezed.dart';
part 'food_item.g.dart';

List<dynamic> stringToList(String photoGallery) {
  return json.decode(photoGallery).cast<String>().toList();
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
    @Default(false) bool? isDiscount,
    @Default(true) bool? isShow,
    @Default(0) double? price,
    @Default('') @JsonKey(name: 'created_at') String? createdAt,
    @Default('') @JsonKey(name: 'updated_at') String? updatedAt,
    @Default(<String>[])
    @JsonKey(name: 'photo_gallery', fromJson: stringToList)
    List photoGallery,
  }) = _FoodItem;

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
}
