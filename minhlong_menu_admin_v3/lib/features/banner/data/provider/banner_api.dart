import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/banner_model.dart';

class BannerApi {
  final Dio _dio;
  BannerApi({required Dio dio}) : _dio = dio;

  Future<BannerModel> getBanners(
      {required int page, required int limit, required String type}) async {
    final response = await _dio.get(ApiConfig.banners,
        queryParameters: {'page': page, 'limit': limit, 'type': type});
    return BannerModel.fromJson(response.data['data']);
  }
}
