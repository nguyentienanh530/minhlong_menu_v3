import 'package:minhlong_menu_admin_v3/features/category/data/model/category_model.dart';
import 'package:minhlong_menu_admin_v3/features/category/data/provider/category_api.dart';

import '../../../../common/network/result.dart';

class CategoryRepository {
  final CategoryApi _categoryApi;

  CategoryRepository({required CategoryApi categoryApi})
      : _categoryApi = categoryApi;

  Future<Result<List<CategoryModel>>> getCategories() async {
    try {
      var response = await _categoryApi.getCategories();
      return Result.success(response);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
