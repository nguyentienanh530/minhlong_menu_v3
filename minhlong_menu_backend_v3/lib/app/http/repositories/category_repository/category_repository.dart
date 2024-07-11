import 'package:minhlong_menu_backend_v3/app/models/category.dart';

class CategoryRepository {
  Future getCategoryCount() async {
    return await Category().query().count();
  }

  Future get({required int startIndex, required int limit}) async {
    return Category()
        .query()
        .offset(startIndex)
        .limit(limit)
        .orderBy('serial', 'asc')
        .get();
  }

  Future getAll() async {
    return Category().query().orderBy('serial', 'asc').get();
  }

  Future find({required int id}) async {
    return await Category().query().where('id', '=', id).first();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await Category().query().insertGetId(data);
  }

  Future update({required int id, required Map<String, dynamic> data}) async {
    return await Category().query().where('id', '=', id).update(data);
  }

  Future destroy({required int id}) async {
    return await Category().query().where('id', '=', id).delete();
  }
}
