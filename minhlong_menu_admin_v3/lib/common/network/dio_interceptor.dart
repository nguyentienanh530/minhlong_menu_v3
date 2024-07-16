import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/auth_local_datasource/auth_local_datasource.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/model/access_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api_config.dart';
import 'dio_client.dart';

class DioInterceptor extends Interceptor {
  final SharedPreferences sf;
  late AuthLocalDatasource _authLocalDatasource;

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
  );

  DioInterceptor(this.sf) {
    _authLocalDatasource = AuthLocalDatasource(sf);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i('====================START====================');
    logger.i('HTTP method => ${options.method} ');
    logger.i('Request => ${options.baseUrl}${options.path}');
    logger.i('Header  => ${options.headers}');
    final accessToken = await _authLocalDatasource.getAccessToken();
    log('token: ${accessToken?.accessToken}');
    if (accessToken != null && accessToken.accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${accessToken.accessToken}';
      options.headers['Content-Type'] = 'application/json';
      options.headers['Accept'] = 'application/json';
    }
    // _addTokenIfNeeded(options, handler);
  }

  void _addTokenIfNeeded(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.containsKey('Authorization')) {
      return handler.next(options);
    }

    final accessToken = await _authLocalDatasource.getAccessToken();
    log('token: ${accessToken?.accessToken}');
    if (accessToken != null && accessToken.accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${accessToken.accessToken}';
      options.headers['Content-Type'] = 'application/json';
      options.headers['Accept'] = 'application/json';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    if (err.response?.data['message'] != 'Token expired' ||
        err.response?.statusCode != 401) {
      return handler.next(err);
    }

    logger.e(options.method); // Debug log
    logger.e(
        'Error: ${err.response!.statusCode}, Message: ${err.message}'); // Error log
    logger.e('Error message: ${err.response?.data['message']}');

    logger.e(
        'Request => ${options.baseUrl}${options.path}${options.queryParameters}');

    _refreshTokenAndResolveError(err, handler);
  }

  void _refreshTokenAndResolveError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _debugPrint('### Refreshing token... ###');
    final token = await _authLocalDatasource.getAccessToken();
    final refreshToken = token?.refreshToken;

    if (refreshToken == null) {
      return handler.next(err);
    }

    late final AccessToken? accessToken;

    try {
      accessToken = await refreshTokenFuction(accessToken: token!) ?? token;
    } catch (e) {
      print('caching error $e');
      // await _authLocalDatasource.removeAccessToken();

      if (e is DioException) {
        return handler.next(e);
      }

      return handler.next(err);
    }

    _debugPrint('### Token refreshed! ###');

    await _authLocalDatasource.saveAccessToken(accessToken);

    err.requestOptions.headers['Authorization'] =
        'Bearer ${accessToken.accessToken}';

    final refreshResponse = await Dio().fetch(err.requestOptions);
    return handler.resolve(refreshResponse);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('Response => StatusCode: ${response.statusCode}'); // Debug log
    logger.d('Response => Body: ${response.data}'); // Debug log
    return super.onResponse(response, handler);
  }

  Future<AccessToken?> refreshTokenFuction(
      {required AccessToken accessToken}) async {
    try {
      final response = await dio.post(
        ApiConfig.refreshToken,
        queryParameters: {'refresh_token': accessToken.refreshToken},
      );

      if (response.statusCode == HttpStatus.created) {
        return AccessToken.fromJson(response.data['data']);
      }
      if (response.statusCode == HttpStatus.ok) {
        return null;
      }
    } catch (e) {
      throw 'refreshToken went wrong $e';
    }
    return null;
  }

  void _debugPrint(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
