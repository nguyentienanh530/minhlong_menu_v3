import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_client_v3/features/category/data/provider/categories_api.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../model/category_model.dart';

class CategoryRepository {
  final CategoryApi _categoriesApi;

  CategoryRepository(CategoryApi categoriesApi)
      : _categoriesApi = categoriesApi;

  Future<Result<List<CategoryModel>>> getCategories() async {
    try {
      var response = await _categoriesApi.getCategories();
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('get category error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
