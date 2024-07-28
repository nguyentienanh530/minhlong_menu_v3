import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'food_order_model.freezed.dart';
part 'food_order_model.g.dart';

List<dynamic> stringToList(String photoGallery) {
  return json.decode(photoGallery).cast<String>().toList();
}

@freezed
class FoodOrderModel with _$FoodOrderModel {
  factory FoodOrderModel({
    @Default(0) int id,
    @Default('') String name,
    final String? image1,
    final String? image2,
    final String? image3,
    final String? image4,
    @Default('') String note,
    @Default(0) double price,
    @Default(0) int quantity,
    @Default(0) @JsonKey(name: 'total_amount') double totalAmount,
    @Default(false) @JsonKey(name: 'is_discount') bool isDiscount,
    @Default(0) @JsonKey(name: 'discount') int discount,
  }) = _FoodOrderModel;

  factory FoodOrderModel.fromJson(Map<String, dynamic> json) =>
      _$FoodOrderModelFromJson(json);
}
