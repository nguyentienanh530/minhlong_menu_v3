import 'package:freezed_annotation/freezed_annotation.dart';
part 'food_item.freezed.dart';
part 'food_item.g.dart';

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
    @Default('') final String? image1,
    @Default('') final String? image2,
    @Default('') final String? image3,
    @Default('') final String? image4,
    @Default('') @JsonKey(name: 'category_name') String categoryName,
  }) = _FoodItem;

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
}
