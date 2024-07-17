part of '../controllers/banner_controller.dart';

extension IndexBannerCtrl on BannerController {
  Future<Response> index(Request request) async {
    var params = request.all();

    try {
      int? page = params['page'] != null ? int.tryParse(params['page']) : null;
      int? limit =
          params['limit'] != null ? int.tryParse(params['limit']) : null;
      var totalItems = await _bannerRepository.bannerCount();
      int totalPages = 0;
      int startIndex = 0;
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      dynamic banner;
      if (page == null && limit == null) {
        banner = await _bannerRepository.getAll(userID: userID);
      } else {
        totalPages = (totalItems / limit).ceil();
        startIndex = (page! - 1) * limit!;
        banner = await _bannerRepository.get(
            startIndex: startIndex, limit: limit, userID: userID);
      }
      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page ?? 1,
          'limit': limit ?? 10,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': banner,
      });
    } catch (e) {
      print('get banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
