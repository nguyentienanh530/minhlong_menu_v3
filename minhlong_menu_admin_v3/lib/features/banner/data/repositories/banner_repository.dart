import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:minhlong_menu_admin_v3/features/banner/data/model/banner_model.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/provider/banner_api.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';

class BannerRepository {
  final BannerApi _bannerApi;
  BannerRepository({required BannerApi bannerApi}) : _bannerApi = bannerApi;

  Future<Result<BannerModel>> getBanners(
      {required int page, required int limit, required String type}) async {
    var response = BannerModel();
    try {
      response =
          await _bannerApi.getBanners(page: page, limit: limit, type: type);
    } on DioException catch (e) {
      Logger().e('get banners error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return Result.success(response);
  }
}
