import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/repositories/category_repository/category_repository.dart';

import 'package:vania/vania.dart';

class CategoryController extends Controller {
  final CategoryRepository _categoryRepository = CategoryRepository();
  Future<Response> index(Request request) async {
    Map<String, dynamic> params = request.all();
    String type = params['type'] ?? 'all';
    int page = int.parse(params['page'] ?? '1');
    int limit = int.parse(params['limit'] ?? '10');

    try {
      final int totalItems = await _categoryRepository.getCategoryCount();
      final int totalPages = (totalItems / limit).ceil();
      final int startIndex = (page - 1) * limit;
      dynamic category;
      if (type == 'all') {
        category = await _categoryRepository.getAll();
      } else {
        category =
            await _categoryRepository.get(startIndex: startIndex, limit: limit);
      }

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

  Future<Response> getCategoryQuantity() async {
    try {
      var quantity = await _categoryRepository.getCategoryCount();
      return AppResponse().ok(data: quantity, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> create(Request request) async {
    Map<String, dynamic> data = request.all();
    try {
      var category = {
        'name': data['name'] ?? '',
        'image': data['image'] ?? '',
        'serial': data['serial'] ?? 0,
      };
      var categoryID = await _categoryRepository.create(data: category);
      return AppResponse().ok(data: categoryID, statusCode: HttpStatus.ok);
    } catch (e) {
      print('create category error: $e');
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

  Future<Response> update(Request request, int id) async {
    Map<String, dynamic> data = request.all();
    try {
      var category = await _categoryRepository.find(id: id);
      if (category == null) {
        return AppResponse().error(
            statusCode: HttpStatus.notFound, message: 'category not found');
      }
      var categoryUpdate = {
        'name': data['name'] ?? category['name'],
        'image': data['image'] ?? category['image'],
        'serial': data['serial'] ?? category['serial'],
      };
      await _categoryRepository.update(id: id, data: categoryUpdate);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('update category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> destroy(int id) async {
    try {
      var category = await _categoryRepository.find(id: id);
      if (category == null) {
        return AppResponse().error(statusCode: HttpStatus.notFound);
      }
      await _categoryRepository.destroy(id: id);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('delete category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}

final CategoryController categoryController = CategoryController();
