import 'package:minhlong_menu_admin_v3/common/network/result.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/model/food_model.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/provider/food_api.dart';

import '../model/food_item.dart';

class FoodRepository {
  final FoodApi _foodApi;

  FoodRepository(FoodApi foodApi) : _foodApi = foodApi;

  Future<Result<FoodModel>> getFoods({required int page, limit}) async {
    try {
      var response = await _foodApi.getFoods(page: page, limit: limit);
      return Result.success(response);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<int>> createFood({required FoodItem food}) async {
    try {
      var response = await _foodApi.createFood(food: food);
      return Result.success(response);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
