import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/repositories/category_repository/category_repository.dart';

import 'package:vania/vania.dart';

class CategoryController extends Controller {
  final CategoryRepository _categoryRepository = CategoryRepository();
  Future<Response> index() async {
    try {
      var category = await _categoryRepository.get();
      return AppResponse().ok(statusCode: HttpStatus.ok, data: category);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> getCategoryQuantity() async {
    try {
      var quantity = await _categoryRepository.getCategoryQuantity();
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

final CategoryController categoryController = CategoryController();
