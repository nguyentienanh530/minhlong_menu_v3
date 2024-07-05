import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item.dart';
import 'pagination_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  factory OrderModel({
    @JsonKey(name: 'pagination') final PaginationModel? paginationModel,
    @Default(<OrderItem>[]) @JsonKey(name: 'data') List<OrderItem> orderItems,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
