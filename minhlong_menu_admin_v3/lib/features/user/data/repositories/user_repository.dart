import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/auth_local_datasource/auth_local_datasource.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/provider/user_api.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';

class UserRepository {
  final UserApi _userApi;
  final AuthLocalDatasource _authLocalDatasource;
  UserRepository(
      {required UserApi userApi,
      required AuthLocalDatasource authLocalDatasource})
      : _userApi = userApi,
        _authLocalDatasource = authLocalDatasource;

  Future<Result<UserModel>> getUser() async {
    var userModel = UserModel();
    try {
      var token = await _authLocalDatasource.getAccessToken();
      userModel = await _userApi.getUser(token: token!.accessToken);
    } on DioException catch (e) {
      Logger().e('get user error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return Result.success(userModel);
  }
}
