import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/repositories/category_repository.dart';

import 'package:vania/vania.dart';
part '../controllers/_index_category.dart';
part '../controllers/_create_category.dart';
part '../controllers/_update_category.dart';
part '../controllers/_destroy_category.dart';

class CategoryController extends Controller {
  final CategoryRepository _categoryRepository;

  CategoryController({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository;

  Future<Response> getCategoryQuantity() async {
    try {
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var quantity = await _categoryRepository.getCategoryCount(userID: userID);
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
