import 'dart:developer';
import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/models/table.dart';
import 'package:vania/vania.dart';
import '../../../../common/const_res.dart';
import '../repositories/table_repo.dart';

class TableController extends Controller {
  final TableRepo tableRepo;

  TableController(this.tableRepo);

  Map<int, List<dynamic>> groupTablesById(List<dynamic> tables) {
    Map<int, List<dynamic>> groupedTables = {};
    for (var table in tables) {
      if (!groupedTables.containsKey(table['id'])) {
        groupedTables[table['id']] = [];
      }
      groupedTables[table['id']]!.add(table);
    }
    return groupedTables;
  }

  Future<Response> getTableQuantity(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var quantity = await tableRepo.getTableCount(userID: userID);
      return AppResponse().ok(data: quantity, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> update(Request request, int id) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    var params = request.all();
    try {
      var table = await tableRepo.find(id: id);

      if (userID == null || userID == -1) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }
      if (table == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'table not found',
        );
      }

      var tableUpdate = {
        // 'user_id': userID ?? table['user_id'],
        'name': params['name'] ?? table['name'],
        'seats': params['seats'] ?? table['seats'],
        'is_use': params['is_use'] == null ? 0 : (params['is_use'] ? 1 : 0),
      };
      await tableRepo.update(id: id, tableDataUpdate: tableUpdate);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      print('update table error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> index(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    Map<String, dynamic> params = request.all();

    int? page = params['page'] != null ? int.tryParse(params['page']) : 1;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : 10;

    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      int totalItems = await tableRepo.getTableCount(userID: userID);

      dynamic tables;

      int totalPages = (totalItems / limit!).ceil();
      int startIndex = (page! - 1) * limit;
      tables = await tableRepo.get(
          startIndex: startIndex, limit: limit, userID: userID);

      return AppResponse().ok(data: {
        'pagination': {
          'page': page,
          'limit': limit,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': tables
      }, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> destroy(int id) async {
    try {
      var table = await tableRepo.find(id: id);
      if (table == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'table not found',
        );
      }
      await tableRepo.delete(id);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      log('delete table error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> create(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    var params = request.all();
    try {
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var table = {
        'user_id': userID,
        'name': params['name'] ?? '',
        'seats': params['seats'] ?? 0,
        'is_use': params['is_use'] == null ? 0 : (params['is_use'] ? 1 : 0),
      };

      var tableID = await tableRepo.create(data: table);
      if (tableID == null || tableID == 0) {
        return AppResponse().error(
          statusCode: HttpStatus.badRequest,
          message: 'create table error',
        );
      }
      return AppResponse().ok(data: tableID, statusCode: HttpStatus.ok);
    } catch (e) {
      print('create table error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}

final TableController tableCtrl = TableController(TableRepo(Tables()));
