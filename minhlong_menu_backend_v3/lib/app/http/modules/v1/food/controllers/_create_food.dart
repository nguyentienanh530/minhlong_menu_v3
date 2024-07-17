part of '../controllers/food_controller.dart';

extension CreateFood on FoodController {
  Future<Response> create(Request request) async {
    print('request: ${request.all()}');
    try {
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var foodData = {
        'user_id': userID,
        'name': request.input('name'),
        'category_id': request.input('category_id'),
        'order_count': request.input('order_count'),
        'description': request.input('description'),
        'discount': request.input('discount'),
        'is_discount': request.input('is_discount') == null
            ? 0
            : (bool.parse(request.input('is_discount').toString()) ? 1 : 0),
        'is_show': request.input('is_show') == null
            ? false
            : (bool.parse(request.input('is_show').toString()) ? 1 : 0),
        'price': request.input('price'),
        'image1': request.input('image1'),
        'image2': request.input('image2'),
        'image3': request.input('image3'),
        'image4': request.input('image4'),
      };

      var foodID = await _foodRepository.create(data: foodData);
      if (foodID != null) {
        return AppResponse().ok(data: foodID, statusCode: HttpStatus.ok);
      }

      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}
