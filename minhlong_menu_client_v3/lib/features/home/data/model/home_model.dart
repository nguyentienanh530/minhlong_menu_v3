import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:minhlong_menu_client_v3/features/banner/data/model/banner_model.dart';
import 'package:minhlong_menu_client_v3/features/category/data/model/category_model.dart';

import '../../../food/data/model/food_item.dart';
part 'home_model.freezed.dart';
part 'home_model.g.dart';

@freezed
class HomeModel with _$HomeModel {
  factory HomeModel({
    @Default(<BannerModel>[])
    @JsonKey(name: 'banners')
    List<BannerModel> banners,
    @Default(<CategoryModel>[])
    @JsonKey(name: 'categories')
    List<CategoryModel> categories,
    @Default(<FoodItem>[]) @JsonKey(name: 'newFoods') List<FoodItem> newFoods,
    @Default(<FoodItem>[])
    @JsonKey(name: 'popularFoods')
    List<FoodItem> popularFoods,
  }) = _HomeModel;

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
}
