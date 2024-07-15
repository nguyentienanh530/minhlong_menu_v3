part of '../controllers/banner_controller.dart';

extension IndexBannerCtrl on BannerController {
  Future<Response> index(Request request) async {
    var params = request.all();
    var type = params['type'] ?? 'all';
    int page = request.input('page') ?? 1;
    int limit = request.input('limit') ?? 10;
    try {
      var totalItems = await _bannerRepository.bannerCount();
      var totalPages = (totalItems / limit).ceil();
      var startIndex = (page - 1) * limit;

      if (type == 'all') {
        var banner = await _bannerRepository.getAll();

        return AppResponse().ok(statusCode: HttpStatus.ok, data: {
          'pagination': {
            'page': page,
            'limit': limit,
            'total_page': totalPages,
            'total_item': totalItems,
          },
          'data': banner,
        });
      } else {
        var banner =
            await _bannerRepository.get(startIndex: startIndex, limit: limit);
        return AppResponse().ok(statusCode: HttpStatus.ok, data: {
          'pagination': {
            'page': page,
            'limit': limit,
            'total_page': totalPages,
            'total_item': totalItems,
          },
          'data': banner,
        });
      }
    } catch (e) {
      print('get banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
