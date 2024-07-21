import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/best_selling_food.dart';
import '../model/info_model.dart';

class InfoApi {
  final Dio dio;

  InfoApi(this.dio);

  Future<InfoModel> getInfo() async {
    final response = await dio.get(ApiConfig.info);
    return InfoModel.fromJson(response.data['data']);
  }

  Future<List<BestSellingFood>> getBestSellingFood() async {
    final response = await dio.get(ApiConfig.bestSellingFood);
    return (List<BestSellingFood>.from(
      response.data['data'].map(
        (bestSellingFood) => BestSellingFood.fromJson(bestSellingFood),
      ),
    ));
  }
}
