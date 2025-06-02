import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import '../../../../core/themes/app_colors.dart';
import '../controllers/scan_boitier_controller.dart';
import 'photo_grid_widget.dart';
import 'comment_widget.dart';

class Step3 extends GetView<ScanBoitierController> {
  @override
  Widget build(BuildContext context) {
    if (controller.step.value != 2) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(children: [
      //
      //       Text(
      //       'stepper_scan_boitier.titles.gestion_ports'.tr(),
      //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
      //     color: AppColors.primary,
      //     fontSize: 18,
      //   ),
      // ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.grey,
          //     // 1) Arrondi de 20 sur les coins supérieurs seulement
          //     borderRadius: const BorderRadius.all(
          //       Radius.circular(20),
          //     ),
          //     // 2) Bordure uniquement en haut
          //     border:  Border(
          //       top: BorderSide(
          //         color: AppColors.primary,
          //         width: 3,
          //       ),
          //     ),
          //   ),

          //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          //   child: Text(
          //     'stepper_scan_boitier.titles.gestion_ports'.tr(),
          //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
          //       color: Colors.white,
          //       fontSize: 18,
          //     ),
          //   ),
          // ),

          // SizedBox(height: 20,),

          Obx(()=>PhotoGridWidget(
            photos: controller.photos.value,
            onAdd: controller.addPhoto,
            onDelete: controller.removePhotoAt,
          ),),
          const SizedBox(height: 20),

          CommentWidget(onChanged: controller.setComment),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
