part of '../controllers/table_controller.dart';

extension UpdateTable on TableController {
  Future<Response> update(Request request, int id) async {
    var params = request.all();
    try {
      var table = await _tableRepository.find(id: id);
      var userID = Auth().id();
      if (userID == null) {
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
        'user_id': userID ?? table['user_id'],
        'name': params['name'] ?? table['name'],
        'seats': params['seats'] ?? table['seats'],
        'is_use': params['is_use'] == null ? 0 : (params['is_use'] ? 1 : 0),
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
}
