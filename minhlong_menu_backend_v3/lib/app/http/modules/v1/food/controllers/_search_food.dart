part of '../controllers/food_controller.dart';

extension SearchFood on FoodController {
  Future<Response> search(Request request) async {
    try {
      var query = request.input('query');
      List<Map<String, dynamic>> foods =
          await _foodRepository.search(query: query);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: foods);
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}