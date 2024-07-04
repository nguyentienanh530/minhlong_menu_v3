import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/info_model.dart';

class InfoApi {
  final Dio dio;

  InfoApi(this.dio);

  Future<InfoModel> getInfo() async {
    final response = await dio.get(ApiConfig.info);
    return InfoModel.fromJson(response.data['data']);
  }
}
