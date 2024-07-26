import '../models/table.dart';

class TableRepo {
  final Tables tables;

  TableRepo(this.tables);
  Future getAllTables({required int userID}) async {
    return await tables.query().where('user_id', '=', userID).get();
  }

  Future get(
      {required int startIndex,
      required int limit,
      required int userID}) async {
    return await tables
        .query()
        .offset(startIndex)
        .where('user_id', '=', userID)
        .limit(limit)
        .get();
  }

  Future getTableCount({required int userID}) async {
    return await tables.query().where('user_id', '=', userID).count();
  }

  Future delete(int id) async {
    return await tables.query().where('id', '=', id).delete();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await tables.query().insertGetId(data);
  }

  Future update(
      {required int id, required Map<String, dynamic> tableDataUpdate}) async {
    return await tables.query().where('id', '=', id).update(tableDataUpdate);
  }

  Future find({required int id}) async {
    return await tables.query().where('id', '=', id).first();
  }
}
