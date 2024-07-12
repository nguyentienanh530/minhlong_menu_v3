import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_model.dart';
import 'package:minhlong_menu_client_v3/features/food/data/provider/food_api.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';

class FoodRepository {
  final FoodApi _foodApi;
  FoodRepository({required FoodApi foodApi}) : _foodApi = foodApi;

  Future<Result<List<FoodModel>>> getFoods(
      {int? limit, required String property}) async {
    List<FoodModel> foods = <FoodModel>[];
    try {
      foods = await _foodApi.getFoods(limit: limit, property: property);
    } on DioException catch (e) {
      Logger().e('get popular food error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return Result.success(foods);
  }
}
