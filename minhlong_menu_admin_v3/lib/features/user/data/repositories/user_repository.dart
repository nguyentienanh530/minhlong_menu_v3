import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/provider/user_api.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';

class UserRepository {
  final UserApi _userApi;

  UserRepository({required UserApi userApi}) : _userApi = userApi;

  Future<Result<UserModel>> getUser() async {
    var userModel = UserModel();
    try {
      userModel = await _userApi.getUser();
    } on DioException catch (e) {
      Logger().e('get user error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return Result.success(userModel);
  }
}
