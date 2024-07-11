import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/model/category_model.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/provider/category_api.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../model/category_item.dart';

class CategoryRepository {
  final CategoryApi _categoryApi;

  CategoryRepository({required CategoryApi categoryApi})
      : _categoryApi = categoryApi;

  Future<Result<CategoryModel>> getCategories(
      {required int page, required int limit, required String type}) async {
    try {
      var response = await _categoryApi.getCategories(
        limit: limit,
        page: page,
        type: type,
      );
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('get category error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<int>> createCategory({required CategoryItem category}) async {
    try {
      var response = await _categoryApi.createCategory(category: category);
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('create category error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> updateCategory({required CategoryItem category}) async {
    try {
      await _categoryApi.updateCategory(category: category);
    } on DioException catch (e) {
      Logger().e('update category error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return const Result.success(true);
  }

  Future<Result<bool>> deleteCategory({required int id}) async {
    try {
      var response = await _categoryApi.deleteCategory(id: id);
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('delete category error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
