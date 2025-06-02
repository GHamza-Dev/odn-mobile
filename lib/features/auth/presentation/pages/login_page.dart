import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/footer.dart';
import '../../../../shared/widgets/language_dropdown.dart';
import '../../../../shared/widgets/uderlined-title.dart';
import '../controllers/auth_controller.dart';
import '../widgets/login_form.dart';
import 'package:easy_localization/easy_localization.dart';
import '/gen/assets.gen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.RTL;
    return Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.bg.path),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              bottomNavigationBar: Footer(),
              backgroundColor: Colors.transparent,
              body: Stack(children: [
                Positioned(
                  top: 40,
                  right: isRtl ? null : 16,
                  left: isRtl ? 16 : null,
                  child: const LanguageDropdown(),
                ),
                Positioned(
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(15.0),
                        height: 400,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50),),
                          color: Colors.white,
                        ),
                        //color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: UnderlinedTitle(
                                title: "app_name".tr(),
                                underlineColor: AppColors.primary,
                                fontSize: 25,
                                isCenteredUnderline: true,
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            // _buildGreyText("Please login with your information"),

                            Expanded(
                              flex: 0,
                              child: Form(child: LoginForm()),
                            ),
                          ],
                        ),
                      ),
                    )),

              ]),
            ),
          );
        }
    );
  }
}
