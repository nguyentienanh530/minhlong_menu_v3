import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/model/user.dart';
import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../../../auth/data/model/access_token.dart';
import '../model/user_model.dart';
import '../provider/user_api.dart';
import '../user_local_datasource/user_local_datasource.dart';

class UserRepo {
  final UserApi _userApi;
  final UserLocalDatasource _userLocalDatasource;

  UserRepo(
      {required UserApi userApi,
      required UserLocalDatasource userLocalDatasource})
      : _userApi = userApi,
        _userLocalDatasource = userLocalDatasource;

  Future<Result<UserModel>> getUser({required AccessToken accessToken}) async {
    try {
      var userModel = await _userApi.getUser(accessToken: accessToken);
      await _userLocalDatasource.saveUserID(userModel.id);
      Logger().i('user: $userModel');
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

  Future<Result<User>> getUsers({required int page, required int limit}) async {
    try {
      var users = await _userApi.getUsers(page: page, limit: limit);
      return Result.success(users);
    } on DioException catch (e) {
      Logger().e('get users error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> deleteUser({required int id}) async {
    try {
      return Result.success(await _userApi.deleteUser(id: id));
    } on DioException catch (e) {
      Logger().e('delete user error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> createUser({required UserModel userModel}) async {
    try {
      return Result.success(await _userApi.createUser(userModel: userModel));
    } on DioException catch (e) {
      Logger().e('create user error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> extendedUser({
    required int userID,
    required String extended,
    required String expired,
  }) async {
    try {
      return Result.success(await _userApi.extenedUser(
        userID: userID,
        extended: extended,
        expired: expired,
      ));
    } on DioException catch (e) {
      Logger().e('extended user error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<List<UserModel>>> searchUser({required dynamic query}) async {
    try {
      var users = await _userApi.searchUser(query: query);
      return Result.success(users);
    } on DioException catch (e) {
      Logger().e('search user error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
