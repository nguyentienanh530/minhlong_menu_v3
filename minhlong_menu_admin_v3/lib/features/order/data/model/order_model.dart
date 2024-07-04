import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  factory OrderModel({
    @Default(0) int page,
    @Default(0) int limit,
    @Default(0) @JsonKey(name: 'total_page') int totalPage,
    @Default(0) @JsonKey(name: 'total_item') int totalItem,
    @Default(<OrderItem>[]) @JsonKey(name: 'data') List<OrderItem> orderItems,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
