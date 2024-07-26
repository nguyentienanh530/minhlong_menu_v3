part of '../controllers/table_controller.dart';

extension IndexTable on TableController {
  Future<Response> index(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    Map<String, dynamic> params = request.all();

    int? page = params['page'] != null ? int.tryParse(params['page']) : null;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : null;

    try {
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      int totalItems = await _tableRepository.getTableCount(userID: userID);
      int totalPages = 0;
      int startIndex = 0;
      dynamic tables;

      if (page == null && limit == null) {
        tables = await _tableRepository.getAllTables(userID: userID);
      } else {
        totalPages = (totalItems / limit!).ceil();
        startIndex = (page! - 1) * limit;
        tables = await _tableRepository.get(
            startIndex: startIndex, limit: limit, userID: userID);
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
}
