import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/model/info_model.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../provider/info_api.dart';

class InfoRespository {
  final InfoApi infoApi;

  InfoRespository(this.infoApi);

  Future<Result<InfoModel>> getInfo() async {
    try {
      final info = await infoApi.getInfo();
      return Result.success(info);
    } on DioException catch (e) {
      var message = DioExceptions.fromDioError(e).toString();
      return Result.failure(message);
    }
  }
}
