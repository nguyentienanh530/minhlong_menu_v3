import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_detail.dart';
part 'order_model.freezed.dart';
part 'order_model.g.dart';

List<Map<String, dynamic>> foodDtoListToJson(List<OrderDetail> orderDetail) {
  return orderDetail.map((food) => food.toJson()).toList();
}

// enum OrdersStatus { isWanting, isNew, isPaymented }

@freezed
class OrderModel with _$OrderModel {
  factory OrderModel(
      {@Default('') String id,
      final String? status,
      @Default(0) @JsonKey(name: 'table_id') int? tableID,
      @Default('') String tableName,
      @Default('') @JsonKey(name: 'payed_at') String? payedAt,
      @Default(0) @JsonKey(name: 'total_price') double? totalPrice,
      @Default('') @JsonKey(name: 'created_at') String createdAt,
      @Default(<OrderDetail>[])
      @JsonKey(toJson: foodDtoListToJson, name: 'order_detail')
      List<OrderDetail> orderDetail}) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
