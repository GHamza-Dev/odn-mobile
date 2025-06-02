import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:switch_config/core/themes/app_colors.dart';
import 'package:switch_config/shared/widgets/custom-button.dart';
import 'package:switch_config/shared/widgets/uderlined-title.dart';
import '../controllers/create_itinerary_controller.dart';

class CreateItineraryPage extends GetView<CreateItineraryController> {
  const CreateItineraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = controller;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("label_menu.create_itinirary".tr(),
            style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomButtonWidget(btnTxt: 'create_itinirary.scan_qr_cable'.tr(), btnFn: ctrl.scanCable,
                  width: 280,
                  icon: const Icon(Icons.qr_code_scanner,color: Colors.white,),
                ),
              ),
              if (ctrl.cableSn.value != null) ...[
                const SizedBox(height: 8),
                UnderlinedTitle(title: 'Cable SN : ${ctrl.cableSn.value}'),
              ],
              const SizedBox(height: 16),

              if(ctrl.cableSn.value != null)
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.my_location),
                  label: Text('create_itinirary.add_point'.tr()),
                  onPressed: ctrl.addCurrentPosition,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: ctrl.coords.length,
                  itemBuilder: (_, i) {
                    final c = ctrl.coords[i];
                    return Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: Text('${i + 1}'),
                            title: Text(
                                'Latitude: ${c.lat.toStringAsFixed(6)},\nLongitude: ${c.lng.toStringAsFixed(6)}'),
                          ),
                        ),
                        IconButton(onPressed: ()=> ctrl.coords.remove(c), icon: Icon(Icons.delete)),

                      ],
                    );
                  },
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 160,
                  child: CustomButtonWidget(
                    btnFn: ctrl.submit,
                    btnTxt: 'confirm'.tr(),
                    iconLeft: false,
                    icon: Icon(
                        Icons.check,
                        color: Colors.white),
                  ),
                ),
              ),


            ],
          );
        }),
      ),
    );
  }
}
