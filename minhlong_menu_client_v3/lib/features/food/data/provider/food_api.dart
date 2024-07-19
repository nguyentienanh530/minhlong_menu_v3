import 'package:dio/dio.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_model.dart';

import '../../../../core/api_config.dart';

class FoodApi {
  final Dio _dio;
  FoodApi({required Dio dio}) : _dio = dio;

  Future<FoodModel> getFoods({int? page, int? limit, String? property}) async {
    final response = await _dio.get(ApiConfig.foods,
        queryParameters: {'page': page, 'limit': limit, 'property': property});
    return FoodModel.fromJson(response.data['data']);
  }

  Future<FoodModel> getFoodsOnCategory(
      {required int page, required int limit, required int categoryID}) async {
    final response = await _dio.get('${ApiConfig.foodsOnCategory}$categoryID',
        queryParameters: {'page': page, 'limit': limit});
    return FoodModel.fromJson(response.data['data']);
  }
}
