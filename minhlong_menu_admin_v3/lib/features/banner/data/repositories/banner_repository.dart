import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:minhlong_menu_admin_v3/features/banner/data/model/banner_model.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/provider/banner_api.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../model/banner_item.dart';

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

  Future<Result<int>> createBanner({required BannerItem banner}) async {
    var response = 0;
    try {
      response = await _bannerApi.createBanner(banner: banner);
    } on DioException catch (e) {
      Logger().e('create banner error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return Result.success(response);
  }

  Future<Result<bool>> updateBanner({required BannerItem banner}) async {
    var response = false;
    try {
      response = await _bannerApi.updateBanner(banner: banner);
    } on DioException catch (e) {
      Logger().e('update banner error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return Result.success(response);
  }

  Future<Result<bool>> deleteBanner({required int id}) async {
    var response = false;
    try {
      response = await _bannerApi.deleteBanner(id: id);
    } on DioException catch (e) {
      Logger().e('delete banner error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return Result.success(response);
  }
}
