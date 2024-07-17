part of '../controllers/banner_controller.dart';

extension UpdateBannerCtrl on BannerController {
  Future<Response> update(Request request, int id) async {
    Map<String, dynamic> data = request.all();
    try {
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var banner = await _bannerRepository.find(id: id);
      if (banner == null) {
        return AppResponse().error(statusCode: HttpStatus.notFound);
      }
      var bannerUpdate = {
        'user_id': userID ?? banner['user_id'],
        'image': data['image'] ?? '',
        'show': data['show'] == null ? 0 : (data['show'] ? 1 : 0),
      };
      await _bannerRepository.update(id: id, data: bannerUpdate);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      print('update banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
