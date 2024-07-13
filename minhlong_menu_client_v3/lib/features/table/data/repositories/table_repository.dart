import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../model/table_model.dart';
import '../provider/table_api.dart';

class TableRepository {
  final TableApi _tableApi;
  TableRepository({required TableApi tableApi}) : _tableApi = tableApi;

  Future<Result<List<TableModel>>> getTableList() async {
    var response = <TableModel>[];
    try {
      response = await _tableApi.getTableList();
    } on DioException catch (e) {
      Logger().e('get table error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return Result.success(response);
  }
}
