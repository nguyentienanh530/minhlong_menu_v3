part of '../controllers/table_controller.dart';

extension DestroyTable on TableController {
  Future<Response> destroy(int id) async {
    try {
      await _tableRepository.delete(id);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      log('delete table error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}
