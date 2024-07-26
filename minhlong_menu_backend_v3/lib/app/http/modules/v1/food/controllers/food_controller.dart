import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/models/foods.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/repositories/food_repo.dart';
import 'package:vania/vania.dart';
import '../../../../common/const_res.dart';

class FoodController extends Controller {
  final FoodRepo foodRepo;

  FoodController(this.foodRepo);

  // Get foods on category for client
  Future<Response> getFoodsOnCategory(Request request, int id) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    var params = request.all();
    int? page = params['page'] != null ? int.tryParse(params['page']) : 10;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : 10;
    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      // if (page == null && limit == null) {}
      var totalItems =
          await foodRepo.foodsCountOnCategory(categoryID: id, userID: userID);
      int totalPages = (totalItems / limit).ceil();
      int startIndex = (page! - 1) * limit!;
      var newFoods = await foodRepo.getFoodsOnCategory(
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

  Future<Response> getTotalNumberOfFoods(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    try {
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var quantity = await foodRepo.getTotalNumberOfFoods(userID: userID);
      return AppResponse().ok(data: quantity, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> update(Request request, int id) async {
    try {
      var food = await foodRepo.find(id: id);

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
      await foodRepo.update(id: id, data: foodUpdate);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> search(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    try {
      var query = request.input('query');

      if (userID == null) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }
      List<Map<String, dynamic>> foods =
          await foodRepo.search(query: query, userID: userID);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: foods);
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> index(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    var params = request.all();
    int? page = params['page'] != null ? int.tryParse(params['page']) : null;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : null;
    String? property = params['property'] ?? 'created_at';
    print('params: $params');

    try {
      Map<String, dynamic> response = <String, dynamic>{};

      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      if (page == null && limit == null) {
        List<Map<String, dynamic>> foods = <Map<String, dynamic>>[];
        foods = await foodRepo.getAll(userID: userID);
        response = {
          'pagination': {
            'page': 0,
            'limit': 0,
            'total_page': 0,
            'total_item': 0,
          },
          'data': foods,
        };
      } else {
        var totalItems = await foodRepo.foodCount(userID: userID);
        var totalPages = (totalItems / limit).ceil();
        var startIndex = (page! - 1) * limit!;
        List<Map<String, dynamic>> foods = <Map<String, dynamic>>[];
        foods = await foodRepo.get(
            userID: userID,
            limit: limit,
            byProperty: property!,
            startIndex: startIndex);
        response = {
          'pagination': {
            'page': page,
            'limit': limit,
            'total_page': totalPages,
            'total_item': totalItems,
          },
          'data': foods,
        };
      }

      return AppResponse().ok(
        data: response,
        statusCode: HttpStatus.ok,
      );
    } catch (e) {
      print('get foods error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> destroy(int id) async {
    try {
      var food = await foodRepo.find(id: id);

      if (food == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'food not found',
        );
      }
      await foodRepo.delete(id: id);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> create(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    try {
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var foodData = {
        'user_id': userID,
        'name': request.input('name'),
        'category_id': request.input('category_id'),
        'order_count': request.input('order_count'),
        'description': request.input('description'),
        'discount': request.input('discount'),
        'is_discount': request.input('is_discount') == null
            ? 0
            : (bool.parse(request.input('is_discount').toString()) ? 1 : 0),
        'is_show': request.input('is_show') == null
            ? false
            : (bool.parse(request.input('is_show').toString()) ? 1 : 0),
        'price': request.input('price'),
        'image1': request.input('image1'),
        'image2': request.input('image2'),
        'image3': request.input('image3'),
        'image4': request.input('image4'),
      };

      var foodID = await foodRepo.create(data: foodData);
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
}

FoodController foodCtrl = FoodController(FoodRepo(Foods()));
