import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:switch_config/shared/widgets/custom-button.dart';

import '../../../../core/themes/app_constants.dart';
import '../../../../shared/widgets/custom-formbuilder-textfield.dart';
import '../../../../shared/widgets/custom-formbuilder-textfield-password.dart';
import '../controllers/auth_controller.dart';

class LoginForm extends GetView<AuthController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CustomFormBuilderTextField(
            focusNode: FocusNode(),
            labelText: 'utilisateur'.tr(),
            name: 'username',
            icon: Icons.person,
            validators: [AppConstants.requiredFieldValidator],
          ),

          const SizedBox(height: 24),

          Obx(
                () => CustomFormBuilderTextFieldPassword(
              validators: [AppConstants.requiredFieldValidator],
              icon: Icons.password,
              labelText: 'password'.tr(),
              focusNode: FocusNode(),
              name: 'password',
              obscureValue: controller.obscure.value,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.obscure.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: controller.toggle,
              ),
            ),
          ),

          const SizedBox(height: 24),


          CustomButtonWidget(
            btnTxt: 'connecter'.tr(),
            width: 200,
            btnFn: controller.handleSubmit,
            icon: Icon(Icons.login,color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
