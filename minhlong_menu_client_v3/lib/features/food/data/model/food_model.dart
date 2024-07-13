import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minhlong_menu_client_v3/common/model/pagination_model.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_item.dart';

part 'food_model.freezed.dart';
part 'food_model.g.dart';

@freezed
class FoodModel with _$FoodModel {
  factory FoodModel(
      {@JsonKey(name: 'pagination') PaginationModel? paginationModel,
      @Default(<FoodItem>[])
      @JsonKey(name: 'data')
      List<FoodItem> foodItems}) = _FoodModel;

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);
}
