import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/repositories/food_repository.dart';
import 'package:vania/vania.dart';

part '../controllers/_index_food.dart';
part '../controllers/_create_food.dart';
part '../controllers/_update_food.dart';
part '../controllers/_destroy_food.dart';
part '../controllers/_search_food.dart';

class FoodController extends Controller {
  final FoodRepository _foodRepository;

  FoodController({required FoodRepository foodRepository})
      : _foodRepository = foodRepository;

  Future<Response> getFoodsOnCategory(Request request, int id) async {
    int limit = request.input('limit') ?? 10;
    int page = request.input('page') ?? 1;
    try {
      var totalItems = await _foodRepository.foodsCountOnCategory(id: id);
      var totalPages = (totalItems / limit).ceil();
      var startIndex = (page - 1) * limit;
      var newFoods = await _foodRepository.getFoodsOnCategory(
        id: id,
        limit: limit,
        startIndex: startIndex,
      );

      return AppResponse().ok(data: {
        'pagination': {
          'page': page,
          'limit': limit,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': newFoods
      }, statusCode: HttpStatus.ok);
    } catch (e) {
      print('get foods on category error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> getTotalNumberOfFoods() async {
    try {
      var quantity = await _foodRepository.getTotalNumberOfFoods();
      return AppResponse().ok(data: quantity, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }
}
