part of '../controllers/category_controller.dart';

extension DestroyCategory on CategoryController {
  Future<Response> destroy(int id) async {
    try {
      var category = await _categoryRepository.find(id: id);
      if (category == null) {
        return AppResponse().error(statusCode: HttpStatus.notFound);
      }
      await _categoryRepository.destroy(id: id);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('delete category error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
