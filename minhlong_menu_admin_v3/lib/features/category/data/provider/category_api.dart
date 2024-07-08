import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/category_model.dart';

class CategoryApi {
  final Dio _dio;

  CategoryApi({required Dio dio}) : _dio = dio;

  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get(ApiConfig.categories);
    return (List<CategoryModel>.from(
        response.data['data'].map((x) => CategoryModel.fromJson(x))));
  }
}
