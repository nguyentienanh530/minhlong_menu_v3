import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:vania/vania.dart';
import '../../../repositories/table_repository/table_repository.dart';

class TableController extends Controller {
  final TableRepository _tableRepository = TableRepository();
  Future<Response> index(Request request) async {
    int page = request.input('page') ?? 1;
    int limit = request.input('limit') ?? 10;
    try {
      final int totalItems = await _tableRepository.getTableCount();
      final int totalPages = (totalItems / limit).ceil();
      final int startIndex = (page - 1) * limit;
      var tables =
          await _tableRepository.get(startIndex: startIndex, limit: limit);
      if (tables == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'table not found');
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

  Future<Response> create() async {
    return Response.json({});
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
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final TableController tableController = TableController();
