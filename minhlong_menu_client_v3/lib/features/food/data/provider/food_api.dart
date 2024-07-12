import 'package:dio/dio.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_model.dart';

import '../../../../core/api_config.dart';

class FoodApi {
  final Dio _dio;
  FoodApi({required Dio dio}) : _dio = dio;

  Future<List<FoodModel>> getFoods(
      {int? limit, required String property}) async {
    final response = await _dio
        .get('${ApiConfig.foods}/$property', queryParameters: {'limit': limit});
    return (List<FoodModel>.from(
        response.data['data'].map((x) => FoodModel.fromJson(x))));
  }
}
