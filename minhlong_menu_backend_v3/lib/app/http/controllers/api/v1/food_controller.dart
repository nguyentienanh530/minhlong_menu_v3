import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/models/food.dart';
import 'package:vania/vania.dart';

class FoodController extends Controller {
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

  Future<Response> create() async {
    return Response.json({});
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
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final FoodController foodController = FoodController();