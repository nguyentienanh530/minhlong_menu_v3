part of '../controllers/food_controller.dart';

extension IndexFood on FoodController {
  Future<Response> index(Request request) async {
    var params = request.all();
    int? page = params['page'] != null ? int.tryParse(params['page']) : null;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : null;
    String? property = params['property'] ?? 'created_at';
    print('params: $params');

    try {
      final userID = Auth().id();
      Map<String, dynamic> response = <String, dynamic>{};

      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      if (page == null && limit == null) {
        List<Map<String, dynamic>> foods = <Map<String, dynamic>>[];
        foods = await _foodRepository.getAll(userID: userID);
        response = {
          'pagination': {
            'page': 0,
            'limit': 0,
            'total_page': 0,
            'total_item': 0,
          },
          'data': foods,
        };
      } else {
        var totalItems = await _foodRepository.foodCount(userID: userID);
        var totalPages = (totalItems / limit).ceil();
        var startIndex = (page! - 1) * limit!;
        List<Map<String, dynamic>> foods = <Map<String, dynamic>>[];
        foods = await _foodRepository.get(
            userID: userID,
            limit: limit,
            byProperty: property!,
            startIndex: startIndex);
        response = {
          'pagination': {
            'page': page,
            'limit': limit,
            'total_page': totalPages,
            'total_item': totalItems,
          },
          'data': foods,
        };
      }

      return AppResponse().ok(
        data: response,
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
