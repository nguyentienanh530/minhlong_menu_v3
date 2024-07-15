import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/banner/data/model/banner_item.dart';

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

  Future<int> createBanner({required BannerItem banner}) async {
    final response = await _dio.post(ApiConfig.banners, data: banner.toJson());
    return response.data['data'];
  }

  Future<bool> updateBanner({required BannerItem banner}) async {
    final response = await _dio.patch('${ApiConfig.banners}/${banner.id}',
        data: banner.toJson());
    return response.data['data'];
  }

  Future<bool> deleteBanner({required int id}) async {
    final response = await _dio.delete('${ApiConfig.banners}/$id');
    return response.data['data'];
  }
}
