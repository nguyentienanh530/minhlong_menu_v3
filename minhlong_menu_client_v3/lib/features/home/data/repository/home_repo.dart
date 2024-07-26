import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../model/home_model.dart';
import '../provider/home_api.dart';

class HomeRepo {
  final HomeApi homeApi;

  HomeRepo(this.homeApi);
  Future<Result<HomeModel>> getHome() async {
    try {
      final result = await homeApi.getHome();
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('get home error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
