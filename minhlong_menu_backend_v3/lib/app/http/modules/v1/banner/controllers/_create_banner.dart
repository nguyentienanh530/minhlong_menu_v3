part of '../controllers/banner_controller.dart';

extension CreateBannerCtrl on BannerController {
  Future<Response> create(Request request) async {
    Map<String, dynamic> data = request.all();
    try {
      print(data);
      var banner = {
        'image': data['image'] ?? '',
        'show': data['show'] == null
            ? 1
            : bool.parse(data['show'].toString())
                ? 1
                : 0,
      };
      var bannerID = await _bannerRepository.create(data: banner);
      return AppResponse().ok(data: bannerID, statusCode: HttpStatus.ok);
    } catch (e) {
      print('create banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
