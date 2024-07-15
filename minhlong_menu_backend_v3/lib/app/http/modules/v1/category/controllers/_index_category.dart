part of '../controllers/category_controller.dart';

extension IndexCategory on CategoryController {
  Future<Response> index(Request request) async {
    Map<String, dynamic> params = request.all();
    String type = params['type'] ?? 'all';
    int page = int.parse(params['page'] ?? '1');
    int limit = int.parse(params['limit'] ?? '10');

    try {
      final int totalItems = await _categoryRepository.getCategoryCount();
      final int totalPages = (totalItems / limit).ceil();
      final int startIndex = (page - 1) * limit;
      dynamic category;
      if (type == 'all') {
        category = await _categoryRepository.getAll();
      } else {
        category =
            await _categoryRepository.get(startIndex: startIndex, limit: limit);
      }

      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page,
          'limit': limit,
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
