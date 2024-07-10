import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/provider/dinner_table_api.dart';

import '../../../../common/network/result.dart';
import '../model/table_model.dart';

class DinnerTableRepository {
  final DinnerTableApi _dinnerTableApi;

  DinnerTableRepository({required DinnerTableApi dinnerTableApi})
      : _dinnerTableApi = dinnerTableApi;

  Future<Result<TableModel>> getDinnerTables(
      {required int page, required int limit}) async {
    try {
      final response =
          await _dinnerTableApi.getDinnerTables(page: page, limit: limit);
      return Result.success(response);
    } catch (e) {
      Logger().e('get table error: $e');
      return Result.failure(e.toString());
    }
  }

  Future<Result<bool>> deleteTable({required int id}) async {
    try {
      final response = await _dinnerTableApi.deleteTable(id: id);
      return Result.success(response);
    } catch (e) {
      Logger().e('delete table error: $e');
      return Result.failure(e.toString());
    }
  }
}
