import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/provider/dinner_table_api.dart';

import '../../../../common/network/dio_exception.dart';
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
    } on DioException catch (e) {
      Logger().e('get table error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<List<TableItem>>> getAllTables() async {
    try {
      final response = await _dinnerTableApi.getAllTables();
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('get all table error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> deleteTable({required int id}) async {
    try {
      final response = await _dinnerTableApi.deleteTable(id: id);
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('delete table error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<int>> createTable({required TableItem table}) async {
    try {
      final response = await _dinnerTableApi.createDinnerTable(table: table);
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('create table error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> updateTable({required TableItem table}) async {
    try {
      final response = await _dinnerTableApi.updateDinnerTable(table: table);
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('update table error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
