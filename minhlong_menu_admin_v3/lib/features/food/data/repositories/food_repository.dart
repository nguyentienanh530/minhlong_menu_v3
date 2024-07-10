import 'package:logger/logger.dart';
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
      Logger().e('get food error: $e');
      return Result.failure(e.toString());
    }
  }

  Future<Result<int>> createFood({required FoodItem food}) async {
    try {
      var response = await _foodApi.createFood(food: food);
      return Result.success(response);
    } catch (e) {
      Logger().e('create food error: $e');
      return Result.failure(e.toString());
    }
  }

  Future<Result<bool>> updateFood({required FoodItem food}) async {
    try {
      var response = await _foodApi.updateFood(food: food);
      return Result.success(response);
    } catch (e) {
      Logger().e('update food error: $e');
      return Result.failure(e.toString());
    }
  }

  Future<Result<bool>> deleteFood({required int id}) async {
    try {
      var response = await _foodApi.deleteFood(id: id);
      return Result.success(response);
    } catch (e) {
      Logger().e('delete food error: $e');
      return Result.failure(e.toString());
    }
  }

  Future<Result<List<FoodItem>>> search({required String query}) async {
    try {
      var response = await _foodApi.search(query: query);
      return Result.success(response);
    } catch (e) {
      Logger().e('search food error: $e');
      return Result.failure(e.toString());
    }
  }
}
