import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/repositories/food_repository/food_repository.dart';
import 'package:minhlong_menu_backend_v3/app/models/food.dart';
import 'package:vania/vania.dart';

class FoodController extends Controller {
  final FoodRepository _foodRepository = FoodRepository();
  Future<Response> getFoods() async {
    try {
      List<Map<String, dynamic>> newFoods =
          await Food().query().where('is_show', '=', 1).get();
      return AppResponse().ok(data: newFoods, statusCode: HttpStatus.ok);
    } catch (e) {
      throw Exception('Something went wrong $e');
    }
  }

  Future<Response> getNewFoods(Request request) async {
    // print('limit: ${request.all()}');
    try {
      var limit = request.input('limit');
      print(limit);
      List<Map<String, dynamic>> newFoods = <Map<String, dynamic>>[];
      if (limit == null) {
        newFoods = await Food()
            .query()
            .where('is_show', '=', 1)
            .orderBy('created_at', 'desc')
            .get();
      } else {
        newFoods = await Food()
            .query()
            .where('is_show', '=', 1)
            .orderBy('created_at', 'desc')
            .limit(int.parse(limit.toString()))
            .get();
      }

      return AppResponse().ok(data: newFoods, statusCode: HttpStatus.ok);
    } catch (e) {
      print(e);
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> getPopularFoods(Request request) async {
    try {
      var limit = request.input('limit');

      List<Map<String, dynamic>> newFoods;
      if (limit == null) {
        newFoods = await Food()
            .query()
            .where('is_show', '=', 1)
            .orderBy('order_count', 'desc')
            .get();
      } else {
        newFoods = await Food()
            .query()
            .where('is_show', '=', 1)
            .orderBy('order_count', 'desc')
            .limit(int.parse(limit.toString()))
            .get();
      }

      return AppResponse().ok(data: newFoods, statusCode: HttpStatus.ok);
    } catch (e) {
      throw Exception('Something went wrong $e');
    }
  }

  Future<Response> getFoodsOnCategory(int id) async {
    try {
      var newFoods = await Food()
          .query()
          .where('is_show', '=', 1)
          .where('category_id', '=', id)
          .get();

      return AppResponse().ok(data: newFoods, statusCode: HttpStatus.ok);
    } catch (e) {
      throw Exception('Something went wrong $e');
    }
  }

  Future<Response> getQuantityOfFood() async {
    try {
      var quantity = await Food().query().count();
      return AppResponse().ok(data: quantity, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> create(Request request) async {
    try {
      var foodData = {
        'name': request.input('name'),
        'category_id': request.input('category_id'),
        'order_count': request.input('order_count'),
        'description': request.input('description'),
        'discount': request.input('discount'),
        'is_discount': request.input('is_discount'),
        'is_show': request.input('is_show'),
        'price': request.input('price'),
        'photo_gallery': request.input('photo_gallery'),
      };
      var foodID = await _foodRepository.create(data: foodData);
      if (foodID != null) {
        return AppResponse().ok(data: foodID, statusCode: HttpStatus.ok);
      }

      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    } catch (e) {
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
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

  Future<Response> update(Request request, int id) async {
    try {
      var food = await _foodRepository.find(id: id);

      if (food == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'food not found',
        );
      }
      var foodUpdate = {
        'name': request.input('name') ?? food['name'],
        'category_id': request.input('category_id') ?? food['category_id'],
        'order_count': request.input('order_count') ?? food['order_count'],
        'description': request.input('description') ?? food['description'],
        'discount': request.input('discount') ?? food['discount'],
        'is_discount': request.input('is_discount') ?? food['is_discount'],
        'is_show': request.input('is_show') ?? food['is_show'],
        'price': request.input('price') ?? food['price'],
        'created_at': request.input('created_at') ?? food['created_at'],
        'updated_at': request.input('updated_at') ?? food['updated_at'],
        'photo_gallery':
            request.input('photo_gallery') ?? food['photo_gallery'],
      };
      await food.update(foodUpdate);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: {'food': food});
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }

  Future<Response> search(Request request) async {
    return Response.json({});
  }

  Future<Response> index(Request request) async {
    try {
      int page = request.input('page') ?? 1;
      int limit = request.input('limit') ?? 10;

      List<Map<String, dynamic>> foods = await _foodRepository.get();

      final int totalItems = foods.length;
      final int totalPages = (totalItems / limit).ceil();
      final int startIndex = (page - 1) * limit;
      final int endIndex = startIndex + limit;

      List<Map<String, dynamic>> pageData = [];
      if (startIndex < totalItems) {
        pageData = foods.sublist(
            startIndex, endIndex < totalItems ? endIndex : totalItems);
      }

      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page,
          'limit': limit,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': pageData,
      });
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}

final FoodController foodController = FoodController();
