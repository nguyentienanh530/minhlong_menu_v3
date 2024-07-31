import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/model/info_model.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../model/best_selling_food.dart';
import '../model/daily_revenue.dart';
import '../model/data_chart.dart';
import '../provider/info_api.dart';

class InfoRespository {
  final InfoApi infoApi;

  InfoRespository(this.infoApi);

  Future<Result<InfoModel>> getInfo() async {
    try {
      final info = await infoApi.getInfo();
      return Result.success(info);
    } on DioException catch (e) {
      Logger().e('get info error: $e');
      var message = DioExceptions.fromDioError(e).toString();
      return Result.failure(message);
    }
  }

  Future<Result<List<BestSellingFood>>> getBestSellingFood() async {
    try {
      final bestSellingFood = await infoApi.getBestSellingFood();
      return Result.success(bestSellingFood);
    } on DioException catch (e) {
      Logger().e('get best selling food error: $e');
      var message = DioExceptions.fromDioError(e).toString();
      return Result.failure(message);
    }
  }

  Future<Result<List<DataChart>>> getDataChart({required String type}) async {
    try {
      final dataChart = await infoApi.getDataChart(type: type);
      return Result.success(dataChart);
    } on DioException catch (e) {
      Logger().e('get data chart error: $e');
      var message = DioExceptions.fromDioError(e).toString();
      return Result.failure(message);
    }
  }

  Future<Result<List<DailyRevenue>>> getDailyRevenue() async {
    try {
      final dailyRevenue = await infoApi.getDailyRevenue();
      return Result.success(dailyRevenue);
    } on DioException catch (e) {
      Logger().e('get daily revenue error: $e');
      var message = DioExceptions.fromDioError(e).toString();
      return Result.failure(message);
    }
  }
}
