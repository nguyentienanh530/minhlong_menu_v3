part of '../controllers/banner_controller.dart';

extension UpdateBannerCtrl on BannerController {
  Future<Response> update(Request request, int id) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    Map<String, dynamic> data = request.all();
    try {
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var banner = await _bannerRepository.find(id: id);
      if (banner == null) {
        return AppResponse().error(statusCode: HttpStatus.notFound);
      }
      var bannerUpdate = {
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
