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
    var params = request.all();
    int? page = params['page'] != null ? int.tryParse(params['page']) : null;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : null;
    int totalPages = 0;
    int startIndex = 0;
    try {
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      if (page == null && limit == null) {}
      var totalItems = await _foodRepository.foodsCountOnCategory(
          categoryID: id, userID: userID);
      totalPages = (totalItems / limit).ceil();
      startIndex = (page! - 1) * limit!;
      var newFoods = await _foodRepository.getFoodsOnCategory(
        categoryID: id,
        limit: limit,
        startIndex: startIndex,
        userID: userID,
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
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var quantity =
          await _foodRepository.getTotalNumberOfFoods(userID: userID);
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
