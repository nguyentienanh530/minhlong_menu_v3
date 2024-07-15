part of '../controllers/banner_controller.dart';

extension DestroyBannerCtrl on BannerController {
  Future<Response> destroy(int id) async {
    try {
      await _bannerRepository.delete(id: id);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      print('delete banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
