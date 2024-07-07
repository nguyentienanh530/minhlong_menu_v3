import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/model/food_model.dart';

import '../../../../core/api_config.dart';

class FoodApi {
  final Dio _dio;

  FoodApi(Dio dio) : _dio = dio;

  Future<FoodModel> getFoods({required int page, limit}) async {
    final response = await _dio
        .get(ApiConfig.foods, queryParameters: {'page': page, 'limit': limit});
    return FoodModel.fromJson(response.data['data']);
  }
}
