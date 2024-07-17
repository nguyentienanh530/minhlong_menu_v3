part of '../controllers/food_controller.dart';

extension IndexFood on FoodController {
  Future<Response> index(Request request) async {
    var params = request.all();
    int? page = params['page'] != null ? int.tryParse(params['page']) : null;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : null;
    String property = request.input('property') ?? 'created_at';
    print('params: $params');

    try {
      final userID = Auth().id();

      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      if (page == null && limit == null) {}

      var totalItems = await _foodRepository.foodCount(userID: userID);
      var totalPages = (totalItems / limit).ceil();
      var startIndex = (page! - 1) * limit!;

      List<Map<String, dynamic>> newFoods = <Map<String, dynamic>>[];
      newFoods = await _foodRepository.get(
          userID: userID,
          limit: limit,
          byProperty: property,
          startIndex: startIndex);

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
