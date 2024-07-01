import 'package:minhlong_menu_backend_v3/app/models/category.dart';

class CategoryRepository {
  Future getCategoryQuantity() async {
    return await Category().query().count();
  }
}
