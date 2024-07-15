import '../models/table.dart';

class TableRepository {
  final Tables _tables;

  TableRepository({required Tables tables}) : _tables = tables;
  Future getAllTables() async {
    return await _tables.query().get();
  }

  Future get({required int startIndex, required int limit}) async {
    return await _tables.query().offset(startIndex).limit(limit).get();
  }

  Future getTableCount() async {
    return await _tables.query().count();
  }

  Future delete(int id) async {
    return await _tables.query().where('id', '=', id).delete();
  }

  Future create({required Map<String, dynamic> data}) async {
    return await _tables.query().insertGetId(data);
  }

  Future update(
      {required int id, required Map<String, dynamic> tableDataUpdate}) async {
    return await _tables.query().where('id', '=', id).update(tableDataUpdate);
  }

  Future find({required int id}) async {
    return await _tables.query().where('id', '=', id).first();
  }
}
