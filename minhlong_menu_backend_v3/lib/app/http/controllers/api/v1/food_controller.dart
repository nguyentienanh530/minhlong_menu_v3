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
    print('request: ${request.all()}');
    try {
      var foodData = {
        'name': request.input('name'),
        'category_id': request.input('category_id'),
        'order_count': request.input('order_count'),
        'description': request.input('description'),
        'discount': request.input('discount'),
        'is_discount':
            bool.parse(request.input('is_discount') ?? 'false') == true ? 1 : 0,
        'is_show':
            bool.parse(request.input('is_show') ?? 'false') == true ? 1 : 0,
        'price': request.input('price'),
        'image1': request.input('image1'),
        'image2': request.input('image2'),
        'image3': request.input('image3'),
        'image4': request.input('image4'),
      };
      print('is_discount ${request.input('is_discount')}');
      print('is_show ${request.input('is_show')}');
      print('foodData: $foodData');
      var foodID = await _foodRepository.create(data: foodData);
      if (foodID != null) {
        return AppResponse().ok(data: foodID, statusCode: HttpStatus.ok);
      }

      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    } catch (e) {
      print('error: $e');
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
        'is_discount': request.input('is_discount') == null
            ? food['is_discount']
            : bool.parse(request.input('is_discount')) == true
                ? 1
                : 0,
        'is_show': request.input('is_show') == null
            ? food['is_show']
            : bool.parse(request.input('is_show')) == true
                ? 1
                : 0,
        'price': request.input('price') ?? food['price'],
        'image1': request.input('image1') ?? food['image1'],
        'image2': request.input('image2') ?? food['image2'],
        'image3': request.input('image3') ?? food['image3'],
        'image4': request.input('image4') ?? food['image4'],
      };
      await _foodRepository.update(id: id, data: foodUpdate);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> destroy(int id) async {
    try {
      var food = await _foodRepository.find(id: id);

      if (food == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'food not found',
        );
      }
      await _foodRepository.delete(id: id);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> search(Request request) async {
    return Response.json({});
  }

  Future<Response> index(Request request) async {
    int page = request.input('page') ?? 1;
    int limit = request.input('limit') ?? 10;
    try {
      final int totalItems = await _foodRepository.foodCount();
      final int totalPages = (totalItems / limit).ceil();
      final int startIndex = (page - 1) * limit;

      List<Map<String, dynamic>> foods =
          await _foodRepository.get(startIndex: startIndex, limit: limit);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page,
          'limit': limit,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': foods,
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
