part of '../controllers/banner_controller.dart';

extension IndexBannerCtrl on BannerController {
  Future<Response> index(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    var params = request.all();

    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      int? page = params['page'] != null ? int.tryParse(params['page']) : null;
      int? limit =
          params['limit'] != null ? int.tryParse(params['limit']) : null;
      var totalItems = await _bannerRepository.bannerCount(userID: userID);
      int totalPages = 0;
      int startIndex = 0;

      dynamic banner;
      if (page == null && limit == null) {
        print('page and limit is null');
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
