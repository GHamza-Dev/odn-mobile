import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:switch_config/features/scan_boitier/presentation/widgets/step3.dart';
import 'package:switch_config/shared/widgets/custom-button.dart';
import 'package:switch_config/shared/widgets/footer.dart';
import '../../../../core/themes/app_colors.dart';
import '../controllers/scan_boitier_controller.dart';
import '../widgets/photo_grid_widget.dart';
import '../widgets/comment_widget.dart';
import '../widgets/step1.dart';
import '../widgets/step2.dart';

class StepperScanBoitierPage extends StatelessWidget {
  const StepperScanBoitierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanBoitierController ctrl = Get.find();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          title: Text(
            'label_menu.scan_boitier'.tr(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: [
              // Stepper header only
              SizedBox(
                height: 72, // Fixed height for stepper
                child: Stepper(
                  onStepTapped: (int step) => null,
                  margin: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  type: StepperType.horizontal,
                  currentStep: ctrl.step.value,
                  controlsBuilder: (_, __) => const SizedBox.shrink(),
                  steps: [
                    Step(title: const Text(''), content: const SizedBox()),
                    Step(title: const Text(''), content: const SizedBox()),
                    Step(title: const Text(''), content: const SizedBox()),
                  ],
                ),
              ),

              // Scrollable content area with remaining space
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: _getStepContent(ctrl.step.value),
                ),
              ),

              // Fixed navigation buttons at bottom
              Container(
                padding: const EdgeInsets.all(16),
                child: _buildNavigationButtons(ctrl),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildNavigationButtons(ScanBoitierController ctrl) {
    return SizedBox(
      height: 45,
      child: Row(
        children: [
          if (ctrl.step.value > 0)
            SizedBox(
              width: 160,
              child: CustomButtonWidget(
                btnFn: () => ctrl.step.value--,
                btnTxt: "precedent".tr(),
                backgroundColor: Colors.grey,
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
          const Spacer(),
          SizedBox(
            width: 160,
            child: CustomButtonWidget(
              btnFn: () {
                if(ctrl.step.value == 0){
                  if(ctrl.passeportProduit.value == null){
                    Get.snackbar(
                      'error'.tr(),
                      'stepper_scan_boitier.step1.error_should_scan_qr_code'.tr(),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                }
                if (ctrl.step.value < 2) {
                  ctrl.step.value++;
                } else {
                  ctrl.submit();
                }
              },
              btnTxt: ctrl.step.value < 2 ? 'suivant'.tr() : 'terminer'.tr(),
              iconLeft: false,
              icon: Icon(
                  ctrl.step.value < 2 ? Icons.arrow_forward_ios : Icons.check,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
  Widget _getStepContent(int step) {
    switch (step) {
      case 0:
        return const Step1();
      case 1:
        return Step2();
      case 2:
        return Step3();
      default:
        return const Step1();
    }
  }
}