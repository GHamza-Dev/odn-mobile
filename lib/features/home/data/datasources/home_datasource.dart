
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:switch_config/core/network/api_endpoints.dart';
import 'package:switch_config/core/router/app_routes.dart';
import 'package:switch_config/core/storage/token_storage.dart';
import '../../../../core/controllers/loading_controller.dart';
import '../../../../core/utils/jwt_utils.dart';

class HomeRemoteDataSource {
  final Dio dio;
  HomeRemoteDataSource(this.dio);

  Future<void> logout() async {
    final loadingCtrl = Get.find<LoadingController>();
    loadingCtrl.show();

    try {
      final token = await SecureTokenStorage.read();
      if (token == null) throw Exception('No token to logout');
      final payload = decodeJwtPayload(token);
      final userId = payload['userId'] as int?;
      if (userId == null) throw Exception('userId not found in token');

      await dio.post(
        ApiEndPoints.LOGOUT,
        data: {'userId': userId},
      );
    } catch (e, st) {
      log('Logout failed: $e\n$st');

    } finally {

      await SecureTokenStorage.clear();
      Get.offAllNamed(Routes.login);
      loadingCtrl.hide();
    }
  }
}
