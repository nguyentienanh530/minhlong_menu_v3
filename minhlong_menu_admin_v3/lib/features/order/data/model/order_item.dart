import 'package:freezed_annotation/freezed_annotation.dart';

import 'food_order_model.dart';
part 'order_item.freezed.dart';
part 'order_item.g.dart';

@freezed
class OrderItem with _$OrderItem {
  factory OrderItem({
    @Default(0) int id,
    @Default('') String status,
    @Default(0) @JsonKey(name: 'table_id') int tableId,
    @Default(0) @JsonKey(name: 'total_price') double totalPrice,
    @JsonKey(name: 'payed_at') String? payedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'deleted_at') String? deletedAt,
    @Default(<FoodOrderModel>[])
    @JsonKey(name: 'foods')
    List<FoodOrderModel> foodOrders,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}
