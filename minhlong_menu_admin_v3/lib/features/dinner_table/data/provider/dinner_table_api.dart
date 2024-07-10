import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/core/api_config.dart';

import '../model/table_model.dart';

class DinnerTableApi {
  DinnerTableApi(Dio dio) : _dio = dio;

  final Dio _dio;

  Future<TableModel> getDinnerTables(
      {required int page, required int limit}) async {
    final response = await _dio.get(ApiConfig.tables);
    return TableModel.fromJson(response.data['data']);
  }
}
