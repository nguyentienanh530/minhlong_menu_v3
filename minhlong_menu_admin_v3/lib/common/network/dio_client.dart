import 'package:dio/dio.dart';
import '../../core/api_config.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: ApiConfig.connectionTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    responseType: ResponseType.json,
  ),
);
