import 'dart:developer';
import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:vania/vania.dart';
import '../../../repositories/table_repository/table_repository.dart';

class TableController extends Controller {
  final TableRepository _tableRepository = TableRepository();
  Future<Response> index(Request request) async {
    Map<String, dynamic> params = request.all();

    int page = int.parse(params['page'] ?? '1');
    int limit = int.parse(params['limit'] ?? '10');
    var type = params['type'] ?? 'all';

    try {
      final int totalItems = await _tableRepository.getTableCount();
      final int totalPages = (totalItems / limit).ceil();
      final int startIndex = (page - 1) * limit;
      dynamic tables;

      if (type == 'all') {
        tables = await _tableRepository.getAllTables();
      } else {
        tables =
            await _tableRepository.get(startIndex: startIndex, limit: limit);
      }

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

  Future<Response> getTableQuantity() async {
    try {
      var quantity = await _tableRepository.getTableCount();
      return AppResponse().ok(data: quantity, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> create(Request request) async {
    var params = request.all();
    try {
      var table = {
        'name': params['name'] ?? '',
        'seats': params['seats'] ?? 0,
        'is_use': params['is_use'] != null
            ? bool.parse(params['is_use'].toString()) == true
                ? 1
                : 0
            : 0,
      };

      var tableID = await _tableRepository.create(data: table);
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

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    var params = request.all();
    try {
      var table = await _tableRepository.find(id: id);
      var tableUpdate = {
        'name': params['name'] ?? table['name'],
        'seats': params['seats'] ?? table['seats'],
        'is_use': params['is_use'] == null
            ? table['is_use']
            : bool.parse(params['is_use'].toString()) == true
                ? 1
                : 0,
      };
      await _tableRepository.update(id: id, tableDataUpdate: tableUpdate);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      print('update table error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> destroy(int id) async {
    try {
      await _tableRepository.delete(id);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      log('delete table error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}

final TableController tableController = TableController();
