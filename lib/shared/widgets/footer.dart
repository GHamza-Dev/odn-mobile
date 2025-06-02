import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switch_config/core/themes/app_colors.dart';
import 'package:switch_config/core/themes/app_constants.dart';


class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
    return Stack(children: [
      Container(
        width: Get.width,
        height: 20.0,
        decoration: BoxDecoration(
          color: AppColors.primary
        ),
        child: Center(
          child: Text(
            "© 2025 YASSIRMSS - TOUS DROITS RÉSERVÉS",
            style:  Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ]);
  }
}
