import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/table_model.dart';

class TableApi {
  final Dio _dio;

  TableApi({required Dio dio}) : _dio = dio;

  Future<List<TableModel>> getTableList() async {
    var response = await _dio.get(ApiConfig.tables);
    return (List<TableModel>.from(
      response.data['data']['data'].map(
        (table) => TableModel.fromJson(table),
      ),
    ));
  }
}
