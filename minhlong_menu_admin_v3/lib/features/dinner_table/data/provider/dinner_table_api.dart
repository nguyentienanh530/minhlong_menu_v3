import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/core/api_config.dart';

import '../model/table_model.dart';

class DinnerTableApi {
  DinnerTableApi(this.dio);

  final Dio dio;

  Future<List<TableModel>> getTableList() async {
    final response = await dio.get(ApiConfig.tables);
    final List<TableModel> dataList = List<TableModel>.from(
      json.decode(json.encode(response.data['data'])).map(
            (item) => TableModel.fromJson(item),
          ),
    );
    return dataList;
  }
}
