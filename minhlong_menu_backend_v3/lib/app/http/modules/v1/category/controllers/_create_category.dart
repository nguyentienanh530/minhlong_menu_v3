part of '../controllers/category_controller.dart';

extension CreateCategory on CategoryController {
  Future<Response> create(Request request) async {
    Map<String, dynamic> data = request.all();
    try {
      var category = {
        'name': data['name'] ?? '',
        'image': data['image'] ?? '',
        'serial': data['serial'] ?? 0,
      };
      var categoryID = await _categoryRepository.create(data: category);
      return AppResponse().ok(data: categoryID, statusCode: HttpStatus.ok);
    } catch (e) {
      print('create category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
