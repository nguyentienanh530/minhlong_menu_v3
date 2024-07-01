import '../../../models/table.dart';

class TableRepository {
  Future getTables() async {
    return await Table().query().get();
  }

  Future getTableQuantity() async {
    return await Table().query().count();
  }
}
