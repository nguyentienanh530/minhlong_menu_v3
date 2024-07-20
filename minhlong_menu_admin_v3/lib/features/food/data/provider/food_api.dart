import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/food/data/model/food_model.dart';

import '../../../../core/api_config.dart';
import '../model/food_item.dart';

class FoodApi {
  final Dio _dio;

  FoodApi(Dio dio) : _dio = dio;

  Future<FoodModel> getFoods({required int page, limit}) async {
    final response = await _dio.get(ApiConfig.foods, queryParameters: {
      'page': page,
      'limit': limit,
      'property': 'created_at'
    });
    log('food: ${response.data}');
    return FoodModel.fromJson(response.data['data']);
  }

  Future<int> createFood({required FoodItem food}) async {
    final response =
        await _dio.post(ApiConfig.foods, queryParameters: food.toJson());
    return response.data['data'];
  }

  Future<bool> updateFood({required FoodItem food}) async {
    final response = await _dio.patch('${ApiConfig.foods}/${food.id}',
        queryParameters: food.toJson()
        // data: food.toJson()
        );
    return response.data['data'] ?? false;
  }

  Future<bool> deleteFood({required int id}) async {
    final response = await _dio.delete('${ApiConfig.foods}/$id');
    return response.data['data'] ?? false;
  }

  Future<List<FoodItem>> search({required String query}) async {
    final response =
        await _dio.get(ApiConfig.search, queryParameters: {'query': query});
    return (List<FoodItem>.from(
        response.data['data'].map((x) => FoodItem.fromJson(x))));
  }
}
