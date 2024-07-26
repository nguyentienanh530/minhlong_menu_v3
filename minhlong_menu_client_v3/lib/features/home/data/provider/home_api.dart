import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/home_model.dart';

class HomeApi {
  final Dio dio;

  HomeApi(this.dio);

  Future<HomeModel> getHome() async {
    final response = await dio.get(ApiConfig.home);
    return HomeModel.fromJson(response.data['data']);
  }
}
