import '../../../models/table.dart';

class TableRepository {
  Future getAllTables() async {
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

  Future create({required Map<String, dynamic> data}) async {
    return await Table().query().insertGetId(data);
  }

  Future update(
      {required int id, required Map<String, dynamic> tableDataUpdate}) async {
    return await Table().query().where('id', '=', id).update(tableDataUpdate);
  }

  Future find({required int id}) async {
    return await Table().query().where('id', '=', id).first();
  }
}
