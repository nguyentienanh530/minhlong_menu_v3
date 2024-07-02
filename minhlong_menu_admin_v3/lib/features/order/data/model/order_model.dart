import 'package:freezed_annotation/freezed_annotation.dart';

import 'food_order_model.dart';
part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  factory OrderModel({
    @Default(0) int id,
    @Default('') String status,
    @Default(0) @JsonKey(name: 'table_id') int tableId,
    @Default(0) @JsonKey(name: 'total_price') double totalPrice,
    @Default('') @JsonKey(name: 'payed_at') String payedAt,
    @Default('') @JsonKey(name: 'created_at') String createdAt,
    @Default('') @JsonKey(name: 'updated_at') String updatedAt,
    @Default(<FoodOrderModel>[])
    @JsonKey(name: 'foods')
    List<FoodOrderModel> foodOrders,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
