part of '../controllers/food_controller.dart';

extension DestroyFood on FoodController {
  Future<Response> destroy(int id) async {
    try {
      var food = await _foodRepository.find(id: id);

      if (food == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'food not found',
        );
      }
      await _foodRepository.delete(id: id);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}
