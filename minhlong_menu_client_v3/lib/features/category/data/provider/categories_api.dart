import 'package:dio/dio.dart';

import '../model/category_model.dart';

class CategoryApi {
  final Dio _dio;

  CategoryApi(Dio dio) : _dio = dio;

  Future<List<CategoryModel>> getCategories() async {
    final response = await _dio.get('/categories');
    return (List<CategoryModel>.from(
        response.data['data']['data'].map((x) => CategoryModel.fromJson(x))));
  }
}
