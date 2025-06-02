import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:switch_config/features/auth/domain/entities/user.dart';
import 'package:switch_config/features/home/domain/usecases/logout_usecase.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/usecases/login_usecase.dart';

class AuthController extends GetxController {
  final LoginUseCase _login;
  AuthController(this._login);


  final formKey   = GlobalKey<FormBuilderState>();
  final obscure   = true.obs;            // true = caché


  void toggle() => obscure.toggle();

  void handleSubmit() async{
    print("submit");
    if (formKey.currentState?.validate() ?? false) {
      User result = await _login(formKey.currentState?.getRawValue("username"), formKey.currentState?.getRawValue("password"));
      await SecureTokenStorage.save(result.accessToken);
      Get.offAllNamed(Routes.home);
    }
  }
  @override
  void onClose() {
    super.onClose();
  }
}