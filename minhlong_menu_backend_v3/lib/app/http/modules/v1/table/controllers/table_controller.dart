import 'dart:developer';
import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:vania/vania.dart';
import '../../../../common/const_res.dart';
import '../repositories/table_repository.dart';
part '../controllers/_create_table.dart';
part '../controllers/_update_table.dart';
part '../controllers/_destroy_table.dart';
part '../controllers/_index_table.dart';

class TableController extends Controller {
  final TableRepository _tableRepository;

  TableController({required TableRepository tableRepository})
      : _tableRepository = tableRepository;

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
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var quantity = await _tableRepository.getTableCount(userID: userID);
      return AppResponse().ok(data: quantity, statusCode: HttpStatus.ok);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
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
}
