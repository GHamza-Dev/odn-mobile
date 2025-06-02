import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:switch_config/shared/widgets/footer.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../../../../core/router/app_routes.dart';
import '../widgets/menubutton_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text('app_name'.tr(),
        style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout,
                color: Colors.white
            ),
            tooltip: 'logout'.tr(),
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: Text(
                'menu'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: cs.primary),
              ),
            ),
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  MenuButton(
                    icon: Icons.camera_alt,
                    label: 'label_menu.scan_boitier'.tr(),
                    route: Routes.scanBoitier,
                  ),
                  MenuButton(
                    icon: Icons.info,
                    label: 'label_menu.passeport_produit'.tr(),
                    route: Routes.recap,
                  ),
                  MenuButton(
                    icon: Icons.map,
                    label: 'label_menu.cartographie'.tr(),
                    route: Routes.tasksMap,
                  ),
                  MenuButton(
                    icon: Icons.map,
                    label: 'label_menu.create_itinirary'.tr(),
                    route: Routes.createItinerary,
                  ),
                  // MenuButton(
                  //   icon: Icons.insert_chart,
                  //   label: 'label_menu.statistiques'.tr(),
                  //   route: Routes.autre,
                  // ),
                ],
              ),
            ))

          ],
        ),
      ),
    );
  }
}