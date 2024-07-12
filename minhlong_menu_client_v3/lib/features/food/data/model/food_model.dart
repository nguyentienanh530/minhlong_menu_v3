import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_model.freezed.dart';
part 'food_model.g.dart';

@freezed
class FoodModel with _$FoodModel {
  factory FoodModel(
      {@Default(0) int id,
      @Default('') String name,
      @Default(0) @JsonKey(name: 'category_id') int categoryID,
      @Default(0) @JsonKey(name: 'order_count') int orderCount,
      @Default('') String description,
      @Default(0) int discount,
      @Default(false) @JsonKey(name: 'is_discount') bool isDiscount,
      @Default(false) @JsonKey(name: 'is_show') bool isShow,
      @Default('') String image1,
      @Default('') String image2,
      @Default('') String image3,
      @Default('') String image4,
      @Default(0) double price,
      @Default('') @JsonKey(name: 'create_at') String createAt}) = _FoodModel;

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);
}
