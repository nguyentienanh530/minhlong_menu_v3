import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/models/categories.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/repositories/category_repo.dart';
import 'package:vania/vania.dart';
import '../../../../common/const_res.dart';

class CategoryController extends Controller {
  final CategoryRepo categoryRepo;

  CategoryController(this.categoryRepo);

  Future<Response> index(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    Map<String, dynamic> params = request.all();

    int? page = params['page'] != null ? int.tryParse(params['page']) : 1;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : 10;

    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      final int totalItems =
          await categoryRepo.getCategoryCount(userID: userID);

      dynamic category;

      int totalPages = (totalItems / limit!).ceil();
      int startIndex = (page! - 1) * limit;
      category = await categoryRepo.get(
          startIndex: startIndex, limit: limit, userID: userID);

      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page,
          'limit': limit,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': category
      });
    } catch (e) {
      print('get category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> update(Request request, int id) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    Map<String, dynamic> data = request.all();
    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var category = await categoryRepo.find(id: id);
      if (category == null) {
        return AppResponse().error(
            statusCode: HttpStatus.notFound, message: 'category not found');
      }
      var categoryUpdate = {
        'name': data['name'] ?? category['name'],
        'image': data['image'] ?? category['image'],
        'serial': data['serial'] ?? category['serial'],
      };
      await categoryRepo.update(id: id, data: categoryUpdate);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('update category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> getCategoryQuantity(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var quantity = await categoryRepo.getCategoryCount(userID: userID);
      return AppResponse().ok(data: quantity, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> create(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    Map<String, dynamic> data = request.all();
    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }

      var category = {
        'name': data['name'] ?? '',
        'image': data['image'] ?? '',
        'serial': data['serial'] ?? 0,
        'user_id': userID
      };
      var categoryID = await categoryRepo.create(data: category);
      return AppResponse().ok(data: categoryID, statusCode: HttpStatus.ok);
    } catch (e) {
      print('create category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> destroy(int id) async {
    try {
      var category = await categoryRepo.find(id: id);
      if (category == null) {
        return AppResponse().error(statusCode: HttpStatus.notFound);
      }
      await categoryRepo.destroy(id: id);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('delete category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}

CategoryController categoryCtrl =
    CategoryController(CategoryRepo(Categories()));
