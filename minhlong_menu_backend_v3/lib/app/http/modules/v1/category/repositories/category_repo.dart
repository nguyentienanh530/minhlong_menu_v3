import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/models/categories.dart';

class CategoryRepo {
  final Categories category;

  CategoryRepo(this.category);

  Future getCategoryCount({required int userID}) async {
    return await category.query().where('user_id', '=', userID).count();
  }

  Future get(
      {required int startIndex,
      required int limit,
      required int userID}) async {
    return category
        .query()
        .offset(startIndex)
        .limit(limit)
        .where('user_id', '=', userID)
        .orderBy('serial', 'asc')
        .get();
  }

  Future getAllForUsers({required int userID}) async {
    return category
        .query()
        .where('user_id', '=', userID)
        .orderBy('serial', 'asc')
        .get();
  }

  Future find({required int id}) async {
    return await category.query().where('id', '=', id).first();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await category.query().insertGetId(data);
  }

  Future update({required int id, required Map<String, dynamic> data}) async {
    return await category.query().where('id', '=', id).update(data);
  }

  Future destroy({required int id}) async {
    return await category.query().where('id', '=', id).delete();
  }
}