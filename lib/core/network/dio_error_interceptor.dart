import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:switch_config/core/controllers/loading_controller.dart';

import '../router/app_routes.dart';
import '../storage/token_storage.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    final loader = Get.find<LoadingController>();
    loader.hide();
    if (err.response?.statusCode == 403) {
      SecureTokenStorage.clear();
      Get.offAllNamed(Routes.login);
      return;
    }

    String title = 'error'.tr();
    String message;

    switch (err.type) {
      case DioExceptionType.cancel:
        message = 'request_cancelled'.tr();
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'request_timeout'.tr();
        break;
      case DioExceptionType.badResponse:
        final data = err.response?.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          message = data['message'] as String;
        } else {
          message = ((data is Map<String, dynamic>)
              ? data['error'] as String?
              : null) ?? 'unknown_error'.tr();
        }
        break;
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        message = 'no_internet'.tr();
        break;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade700,
      colorText: Colors.white,
    );

    handler.next(err);
  }
}
