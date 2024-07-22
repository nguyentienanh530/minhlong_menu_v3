import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/model/data_chart.dart';

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

  Future<List<DataChart>> getDataChart({required String type}) async {
    final response =
        await dio.get(ApiConfig.dataChart, queryParameters: {'type': type});
    return (List<DataChart>.from(
      response.data['data'].map(
        (dataChart) => DataChart.fromJson(dataChart),
      ),
    ));
  }
}
