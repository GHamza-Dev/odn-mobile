import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:switch_config/core/network/api_endpoints.dart';
import 'package:switch_config/core/themes/app_constants.dart';

import '../storage/token_storage.dart';
import 'dio_error_interceptor.dart';

final Dio dioClient = _createDio();

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndPoints.server,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.addAll([
    DioErrorInterceptor(),
    LogInterceptor(
      request: kDebugMode,
      requestBody: kDebugMode,
      responseBody: kDebugMode,
    ),
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await SecureTokenStorage.read();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  ]
  );
  return dio;
}
