part of '../controllers/food_controller.dart';

extension IndexFood on FoodController {
  Future<Response> index(Request request) async {
    int limit = request.input('limit') ?? 10;
    int page = request.input('page') ?? 1;
    String property = request.input('property') ?? 'created_at';

    try {
      var totalItems = await _foodRepository.foodCount();
      var totalPages = (totalItems / limit).ceil();
      var startIndex = (page - 1) * limit;

      List<Map<String, dynamic>> newFoods = <Map<String, dynamic>>[];
      newFoods = await _foodRepository.get(
          limit: limit, byProperty: property, startIndex: startIndex);

      return AppResponse().ok(
        data: {
          'pagination': {
            'page': page,
            'limit': limit,
            'total_page': totalPages,
            'total_item': totalItems,
          },
          'data': newFoods,
        },
        statusCode: HttpStatus.ok,
      );
    } catch (e) {
      print('get foods error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}
