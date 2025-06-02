import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:switch_config/core/utils/functions.dart';
import 'package:switch_config/features/scan_boitier/presentation/controllers/scan_boitier_controller.dart';
import 'package:switch_config/features/scan_boitier/presentation/pages/body_passeport_produit.dart';
import 'package:switch_config/features/scan_boitier/presentation/widgets/schema_port.dart';
import 'package:switch_config/gen/assets.gen.dart';
import 'package:switch_config/shared/widgets/footer.dart';
import 'package:switch_config/shared/widgets/uderlined-title.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/custom-button.dart';

class PasseportProduit extends GetView<ScanBoitierController> {
  const PasseportProduit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text('label_menu.passeport_produit'.tr(),
            style: const TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CustomButtonWidget(
                  btnTxt: 'passeport_produit.btn_scan'.tr(),
                  icon: const Icon(Icons.qr_code, color: Colors.white),
                  btnFn: () => controller.scanQrCode(isPasseport: true),
                  width: 200,
                ),
              ),
            ),
          ),
          Obx(()=>
          (controller.passeportProduit.value != null) ?
            Expanded(
                flex: 1,
                child: PasseportProduitBody(produit: controller.passeportProduit.value))
              : SizedBox.shrink()
    ),
        ],
      )
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title, subtitle;
  const _InfoCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.primary, fontSize: 16),
        ),
      ),
    );
  }
}