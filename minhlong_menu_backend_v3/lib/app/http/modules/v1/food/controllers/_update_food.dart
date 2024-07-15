part of '../controllers/food_controller.dart';

extension UpdateFood on FoodController {
  Future<Response> update(Request request, int id) async {
    try {
      var food = await _foodRepository.find(id: id);

      if (food == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'food not found',
        );
      }
      var foodUpdate = {
        'name': request.input('name') ?? food['name'],
        'category_id': request.input('category_id') ?? food['category_id'],
        'order_count': request.input('order_count') ?? food['order_count'],
        'description': request.input('description') ?? food['description'],
        'discount': request.input('discount') ?? food['discount'],
        'is_discount': request.input('is_discount') == null
            ? food['is_discount']
            : bool.parse(request.input('is_discount')) == true
                ? 1
                : 0,
        'is_show': request.input('is_show') == null
            ? food['is_show']
            : bool.parse(request.input('is_show')) == true
                ? 1
                : 0,
        'price': request.input('price') ?? food['price'],
        'image1': request.input('image1') ?? food['image1'],
        'image2': request.input('image2') ?? food['image2'],
        'image3': request.input('image3') ?? food['image3'],
        'image4': request.input('image4') ?? food['image4'],
      };
      await _foodRepository.update(id: id, data: foodUpdate);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
