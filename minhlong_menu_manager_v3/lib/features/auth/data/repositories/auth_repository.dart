import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../../../user/data/user_local_datasource/user_local_datasource.dart';
import '../auth_local_datasource/auth_local_datasource.dart';
import '../dto/login_dto.dart';
import '../model/access_token.dart';
import '../provider/remote/auth_api.dart';

class AuthRepository {
  AuthRepository({
    required this.authLocalDatasource,
    required this.authApi,
    required this.userLocalDatasource,
  });

  final AuthApi authApi;
  final AuthLocalDatasource authLocalDatasource;
  final UserLocalDatasource userLocalDatasource;

  Future<Result<bool>> login(LoginDto login) async {
    try {
      final accessToken = await authApi.login(login);
      await authLocalDatasource.saveAccessToken(accessToken);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
    return const Result.success(true);
  }

  Future<Result<AccessToken?>> getToken() async {
    try {
      final accessToken = await authLocalDatasource.getAccessToken();
      if (accessToken == null) {
        return const Result.success(null);
      }
      return Result.success(accessToken);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> logout() async {
    try {
      // await authApi.logout();
      await authLocalDatasource.removeAccessToken();
      await userLocalDatasource.removeUserID();
      return const Result.success(null);
    } catch (e) {
      return Result.failure('$e');
    }
  }

  Future<Result<bool>> forgotPassword({required LoginDto login}) async {
    try {
      final result = await authApi.forgotPassword(login: login);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('forgot password error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<AccessToken>> refreshToken(
      {required String refreshToken}) async {
    try {
      final result = await authApi.refreshToken(refreshToken: refreshToken);
      await authLocalDatasource.saveAccessToken(result);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('refresh token error: $e');
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
