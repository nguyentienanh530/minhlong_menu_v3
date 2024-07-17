part of '../controllers/table_controller.dart';

extension CreateTable on TableController {
  Future<Response> create(Request request) async {
    var params = request.all();
    try {
      final userID = Auth().id();
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
}
