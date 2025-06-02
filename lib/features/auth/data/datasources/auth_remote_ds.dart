
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:switch_config/core/network/api_endpoints.dart';
import 'package:switch_config/core/storage/token_storage.dart';
import '../../../../core/controllers/loading_controller.dart';
import '../../../../core/utils/jwt_utils.dart';
import '../../domain/usecases/login_usecase.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSource(this.dio);

  Future<UserModel> login(String user, String pwd) async {


    final loader = Get.find<LoadingController>();

    try {
      // loader.show();
      // await Future.delayed(const Duration(seconds: 3));


      log(name:"data >", jsonEncode({'username': user, 'password': pwd}));
      final res = await dio.post(ApiEndPoints.LOGIN, data: {'username': user, 'password': pwd});
      return UserModel.fromJson(res.data as Map<String, dynamic>);

      // 3) Retourne le JSON mock
      const mockJson = {
        "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
            "W5f9jQz1Xk3Q7p2z8Y0fV3nR6uO2t_Lr2JxHjSdDg4E",
        "refreshToken": "dGhpc0lzQVRlc3RSZWZyZXNodG9rZW5WYWx1ZQ==",
        "tokenType": "Bearer",
        "expiresIn": 3600,
        "username": "john.doe",
        "roles": ["ROLE_USER","ROLE_ADMIN"]
      };
      return UserModel.fromJson(mockJson);
    } finally {

      loader.hide();
    }
  }

}
