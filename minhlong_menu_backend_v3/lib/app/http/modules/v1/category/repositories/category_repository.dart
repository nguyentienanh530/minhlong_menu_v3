import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/models/category.dart';

class CategoryRepository {
  final Category _category;

  CategoryRepository({required Category category}) : _category = category;

  Future getCategoryCount() async {
    return await _category.query().count();
  }

  Future get({required int startIndex, required int limit}) async {
    return _category
        .query()
        .offset(startIndex)
        .limit(limit)
        .orderBy('serial', 'asc')
        .get();
  }

  Future getAll() async {
    return _category.query().orderBy('serial', 'asc').get();
  }

  Future find({required int id}) async {
    return await _category.query().where('id', '=', id).first();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await _category.query().insertGetId(data);
  }

  Future update({required int id, required Map<String, dynamic> data}) async {
    return await _category.query().where('id', '=', id).update(data);
  }

  Future destroy({required int id}) async {
    return await _category.query().where('id', '=', id).delete();
  }
}
