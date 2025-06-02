import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:switch_config/features/scan_boitier/presentation/pages/body_passeport_produit.dart';
import 'package:switch_config/shared/widgets/custom-formbuilder-textfield.dart';
import 'package:switch_config/shared/widgets/uderlined-title.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_constants.dart';
import '../../../../shared/widgets/custom-button.dart';
import '../controllers/scan_boitier_controller.dart';

class Step1 extends GetView<ScanBoitierController> {
  const Step1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(
            'stepper_scan_boitier.titles.scan_boitier'.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primary,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          CustomButtonWidget(
            btnTxt: 'stepper_scan_boitier.step1.btn_scan'.tr(),
            icon: Icon(Icons.qr_code,color: Colors.white,),
            btnFn: controller.scanQrCode,
            width: 200,
          ),



          // FIX PROBLEM HEIGHT
          Obx(()=>
          (controller.passeportProduit.value != null) ?
          Container(
              child: PasseportProduitBody(produit: controller.passeportProduit.value))
              : SizedBox.shrink()
          ),

          // const SizedBox(height: 12),
          //
          // CustomButtonWidget(
          //   btnTxt: 'stepper_scan_boitier.step1.btn_manual'.tr(),
          //   btnFn: () => _showManualInputDialog(context),
          //   width: 200,
          // ),
        ],
    );
  }

  // Future<void> _showManualInputDialog(BuildContext context) async {
  //   // 1️⃣ Clé pour piloter le FormBuilder
  //   final formKey = GlobalKey<FormBuilderState>();
  //
  //   // 2️⃣ Affiche le dialogue
  //   final result = await showDialog<String>(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       backgroundColor: Colors.white,
  //       title: Text('stepper_scan_boitier.step1.manual_input_title'.tr()),
  //       content: FormBuilder(
  //         key: formKey,
  //         child: CustomFormBuilderTextField(
  //           name: "numSerieManual",
  //           labelText: "stepper_scan_boitier.step1.manual_input_hint".tr(),
  //           focusNode: FocusNode(),
  //           validators: [
  //             AppConstants.requiredFieldValidator,  // impératif
  //           ],
  //         ),
  //       ),
  //       actions: [
  //
  //         TextButton(
  //           onPressed: () => Navigator.of(ctx).pop(),
  //           child: Text('cancel'.tr()),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             // Sauvegarde + validation
  //             if (formKey.currentState?.saveAndValidate() ?? false) {
  //               final input = formKey.currentState!.value['numSerieManual'] as String;
  //               Navigator.pop(ctx, input);
  //             }
  //           },
  //           child: Text('confirm'.tr()),
  //         ),
  //
  //       ],
  //     ),
  //   );
  //
  //   // 3️⃣ Si l’utilisateur a validé, on passe à l’étape suivante
  //   if (result != null && result.isNotEmpty) {
  //     controller.boitier.value = result;
  //     await controller.loadPorts();
  //     controller.step.value     = 1;
  //     controller.step.refresh();
  //   }
  // }

}
