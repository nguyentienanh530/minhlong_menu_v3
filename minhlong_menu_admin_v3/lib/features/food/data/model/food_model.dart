import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minhlong_menu_admin_v3/common/model/pagination_model.dart';

import 'food_item.dart';
part 'food_model.freezed.dart';
part 'food_model.g.dart';

@freezed
class FoodModel with _$FoodModel {
  factory FoodModel({
    @JsonKey(name: 'pagination') final PaginationModel? paginationModel,
    @Default(<FoodItem>[]) @JsonKey(name: 'data') List<FoodItem> foodItems,
  }) = _FoodModel;

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);
}
