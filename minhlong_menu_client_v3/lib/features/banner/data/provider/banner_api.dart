import 'package:dio/dio.dart';
import 'package:minhlong_menu_client_v3/features/banner/data/model/banner_model.dart';

import '../../../../core/api_config.dart';

class BannerApi {
  final Dio _dio;

  BannerApi(Dio dio) : _dio = dio;

  Future<List<BannerModel>> getBanners() async {
    final response = await _dio.get(ApiConfig.banners);
    return (List<BannerModel>.from(
      response.data['data']['data'].map(
        (banner) => BannerModel.fromJson(banner),
      ),
    ));
  }
}
