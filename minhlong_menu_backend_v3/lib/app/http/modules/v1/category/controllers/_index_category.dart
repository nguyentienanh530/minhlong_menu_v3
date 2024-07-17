part of '../controllers/category_controller.dart';

extension IndexCategory on CategoryController {
  Future<Response> index(Request request) async {
    Map<String, dynamic> params = request.all();

    int? page = params['page'] != null ? int.tryParse(params['page']) : null;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : null;
    int totalPages = 0;
    int startIndex = 0;
    try {
      final int totalItems = await _categoryRepository.getCategoryCount();
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }

      dynamic category;
      if (page == null && limit == null) {
        category = await _categoryRepository.getAll(userID: userID);
      } else {
        totalPages = (totalItems / limit!).ceil();
        startIndex = (page! - 1) * limit;
        category = await _categoryRepository.get(
            startIndex: startIndex, limit: limit, userID: userID);
      }

      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page ?? 1,
          'limit': limit ?? 10,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': category
      });
    } catch (e) {
      print('get category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
