import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/common/network/result.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/auth_local_datasource/auth_local_datasource.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/model/access_token.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/provider/remote/auth_api.dart';
import '../../../../common/network/dio_exception.dart';
import '../dto/login_dto.dart';

class AuthRepository {
  AuthRepository({required this.authLocalDatasource, required this.authApi});

  final AuthApi authApi;
  final AuthLocalDatasource authLocalDatasource;

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
      return const Result.success(null);
    } catch (e) {
      return Result.failure('$e');
    }
  }
}
