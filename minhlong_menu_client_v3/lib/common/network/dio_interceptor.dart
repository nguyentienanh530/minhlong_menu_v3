import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_client_v3/core/const_res.dart';
import 'package:minhlong_menu_client_v3/features/user/data/user_local_datasource/user_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptor extends Interceptor {
  final SharedPreferences sf;
  late UserLocalDatasource userLocalDatasource;

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
  );

  DioInterceptor(this.sf) {
    userLocalDatasource = UserLocalDatasource(sf);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i('====================START====================');
    logger.i('HTTP method => ${options.method} ');
    logger.i('Request => ${options.baseUrl}${options.path}');
    logger.i('Header  => ${options.headers}');
    _addTokenIfNeeded(options, handler);
    // super.onRequest(options, handler);
  }

  void _addTokenIfNeeded(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final userID = await userLocalDatasource.getUserID();
    log('userID: $userID');
    if (userID != null && userID.isNotEmpty) {
      options.headers[ConstRes.userID] = userID;
      options.headers['Content-Type'] = 'application/json';
      options.headers['Accept'] = 'application/json';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    // if (err.response?.statusCode != 401 &&
    //     err.response?.data['message'] != 'Invalid token') {
    //   return handler.next(err);
    // } else {
    //   // await _authLocalDatasource.removeAccessToken();

    //   _refreshTokenAndResolveError(err, handler);
    // }

    logger.e(options.method); // Debug log
    logger.e(
        'Error: ${err.response!.statusCode}, Message: ${err.message}'); // Error log
    logger.e('Error message: ${err.response?.data['message']}');

    logger.e(
        'Request => ${options.baseUrl}${options.path}${options.queryParameters}');
    super.onError(err, handler);
  }

  // void _refreshTokenAndResolveError(
  //   DioException err,
  //   ErrorInterceptorHandler handler,
  // ) async {
  //   _debugPrint('### Refreshing token... ###');
  //   final token = await _authLocalDatasource.getAccessToken();
  //   // final refreshToken = token?.refreshToken;

  //   if (token == null ||
  //       token.accessToken.isEmpty ||
  //       token.refreshToken.isEmpty) {
  //     return handler.next(err);
  //   }

  //   late final AccessToken? accessToken;

  //   try {
  //     accessToken = await refreshTokenFuction(token: token) ?? token;
  //   } on DioException catch (e) {
  //     print('caching error $e');
  //     await _authLocalDatasource.removeAccessToken();

  //     return handler.next(e);
  //   }

  //   _debugPrint('### Token refreshed! ###');

  //   err.requestOptions.headers['Authorization'] =
  //       'Bearer ${accessToken.accessToken}';

  //   final refreshResponse = await Dio().fetch(err.requestOptions);
  //   return handler.resolve(refreshResponse);
  // }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('Response => StatusCode: ${response.statusCode}'); // Debug log
    logger.d('Response => Body: ${response.data}'); // Debug log
    return super.onResponse(response, handler);
  }
}
