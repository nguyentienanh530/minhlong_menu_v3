import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../../../auth/data/model/access_token.dart';
import '../model/user_model.dart';
import '../provider/user_api.dart';

class UserRepository {
  final UserApi _userApi;

  UserRepository({required UserApi userApi}) : _userApi = userApi;

  Future<Result<UserModel>> getUser({required AccessToken accessToken}) async {
    try {
      var userModel = await _userApi.getUser(accessToken: accessToken);
      return Result.success(userModel);
    } on DioException catch (e) {
      Logger().e('get user error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> updateUser({required UserModel userModel}) async {
    try {
      return Result.success(await _userApi.updateUser(userModel: userModel));
    } on DioException catch (e) {
      Logger().e('update user error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      var result = await _userApi.updatePassword(
          oldPassword: oldPassword, newPassword: newPassword);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('update password error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
