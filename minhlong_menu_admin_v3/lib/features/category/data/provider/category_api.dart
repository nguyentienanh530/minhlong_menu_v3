import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/model/category_item.dart';

import '../../../../core/api_config.dart';
import '../model/category_model.dart';

class CategoryApi {
  final Dio _dio;

  CategoryApi({required Dio dio}) : _dio = dio;

  Future<CategoryModel> getCategories(
      {required int page, required int limit, required String type}) async {
    final response = await _dio.get(
      ApiConfig.categories,
      queryParameters: {
        'page': page,
        'limit': limit,
        'type': type,
      },
    );
    return CategoryModel.fromJson(response.data['data']);
  }

  Future<int> createCategory({required CategoryItem category}) async {
    final response =
        await _dio.post(ApiConfig.categories, data: category.toJson());
    return response.data['data'];
  }

  Future<bool> deleteCategory({required int id}) async {
    final response = await _dio.delete('${ApiConfig.categories}/$id');
    return response.data['data'];
  }

  Future<bool> updateCategory({required CategoryItem category}) async {
    final response = await _dio.patch('${ApiConfig.categories}/${category.id}',
        data: category.toJson());
    return response.data['data'];
  }
}
