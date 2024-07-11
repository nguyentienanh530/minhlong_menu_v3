import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_client_v3/features/banner/data/model/banner_model.dart';
import 'package:minhlong_menu_client_v3/features/banner/data/provider/banner_api.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';

class BannerRepository {
  final BannerApi _bannerApi;
  BannerRepository(BannerApi bannerApi) : _bannerApi = bannerApi;

  Future<Result<List<BannerModel>>> getBanners() async {
    try {
      final response = await _bannerApi.getBanners();
      return Result.success(response);
    } on DioException catch (e) {
      Logger().e('get banners error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
