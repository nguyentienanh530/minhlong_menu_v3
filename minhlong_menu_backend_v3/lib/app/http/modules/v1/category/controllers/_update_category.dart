part of '../controllers/category_controller.dart';

extension UpdateCategory on CategoryController {
  Future<Response> update(Request request, int id) async {
    Map<String, dynamic> data = request.all();
    try {
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var category = await _categoryRepository.find(id: id);
      if (category == null) {
        return AppResponse().error(
            statusCode: HttpStatus.notFound, message: 'category not found');
      }
      var categoryUpdate = {
        'user_id': userID ?? category['user_id'],
        'name': data['name'] ?? category['name'],
        'image': data['image'] ?? category['image'],
        'serial': data['serial'] ?? category['serial'],
      };
      await _categoryRepository.update(id: id, data: categoryUpdate);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('update category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
