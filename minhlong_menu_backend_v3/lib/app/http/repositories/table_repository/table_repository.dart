import '../../../models/table.dart';

class TableRepository {
  Future getTables() async {
    return await Table().query().get();
  }

  Future get({required int startIndex, required int limit}) async {
    return await Table().query().offset(startIndex).limit(limit).get();
  }

  Future getTableCount() async {
    return await Table().query().count();
  }

  Future delete(int id) async {
    return await Table().query().where('id', '=', id).delete();
  }
}
