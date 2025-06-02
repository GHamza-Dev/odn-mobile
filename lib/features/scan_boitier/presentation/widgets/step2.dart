import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:switch_config/core/themes/app_constants.dart';
import 'package:switch_config/features/scan_boitier/presentation/widgets/arrowcablepainter.dart';
import 'package:switch_config/shared/widgets/uderlined-title.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/warning.dart';
import '../../domain/entities/clientinfo.dart';
import '../../domain/entities/port.dart';
import '../controllers/scan_boitier_controller.dart';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

class Step2 extends GetView<ScanBoitierController> {
  const Step2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.currentBoitier != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              'stepper_scan_boitier.titles.gestion_ports'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontSize: 18,
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: Get.width,
              child: Text(
                'stepper_scan_boitier.step2.serial_number'.tr(
                  namedArgs: {
                    'serialNum': controller.boitier["sn"] ??
                        "N/A", // Use "sn" instead of "type" if needed
                  },
                ),
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            if ((controller.currentBoitier?.numberOfInputs ?? 0) > 0 ||
                (controller.currentBoitier?.numberOfOutputs ?? 0) > 0)
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 5,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((controller.currentBoitier?.numberOfInputs as int? ?? 0) >
                        0)
                      Obx(() {
                        final scannedIn = controller.inputSerialNumber != "";
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                scannedIn ? Colors.red : Colors.grey,
                            child: const Text('IN',
                                style:
                                    TextStyle(fontSize: 13, color: Colors.white)),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                scannedIn ? 'INPUT :' : 'INPUT',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              if (scannedIn)
                                Text(
                                  controller.inputSerialNumber.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 13),
                                ),
                            ],
                          ),
                          trailing: Transform.scale(
                            scale: 0.7,
                            child: Switch.adaptive(
                              value: scannedIn,
                              onChanged: (_) =>
                                  controller.toggleOrScanInputOutput(true),
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                        );
                      }),


                    // if ((controller.currentBoitier?.numberOfInputs as int? ?? 0) >
                    //         0 &&
                    //     (controller.currentBoitier?.numberOfOutputs as int? ??
                    //             0) >
                    //         0)
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //     child: SizedBox(
                    //       width: double.infinity,
                    //       height: 60, // ajuste si besoin
                    //       child: CustomPaint(
                    //         painter: ArrowCablePainter(
                    //           color: Colors.blueGrey,
                    //           lineWidth: 2.0,
                    //           arrowSize: 10.0,
                    //         ),
                    //       ),
                    //     ),
                    //   ),


                    if ((controller.currentBoitier?.numberOfOutputs as int? ??
                            0) >
                        0)
                      Obx(() {
                        final scannedOut = controller.outputSerialNumber != "";
                        return Container(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  scannedOut ? Colors.red : Colors.grey,
                              child: const Text('OUT',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white)),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  scannedOut ? 'OUTPUT :' : 'OUTPUT',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                if (scannedOut)
                                  Directionality(
                                    textDirection: ui.TextDirection.ltr,
                                    child: Text(
                                      controller.outputSerialNumber.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 13),
                                    ),
                                  ),
                              ],
                            ),
                            trailing: Transform.scale(
                              scale: 0.7,
                              child: Switch.adaptive(
                                value: scannedOut,
                                onChanged: (_) =>
                                    controller.toggleOrScanInputOutput(false),
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        );
                      }),
                  ],
                ),
              ),
            Obx(() {
              final list = controller.ports.value;
              if (list.isEmpty) {
                return Center(
                    child: Warning(
                        title: "stepper_scan_boitier.step2.no_ports_found".tr()));
              }
              return Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border(
                    top: BorderSide(
                      color: Colors.blueGrey,
                      width: 5,
                    ),
                  ),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.ports.value.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    Port port = controller.ports.value[i];
                    print("port.toString()");
                    print(port.toString());
                    final isUsed = port.status?.toLowerCase() == 'used';
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: isUsed ? Colors.red : Colors.grey,
                        child: Text(
                          port.portNumber.toString(),
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isUsed
                                  ? 'stepper_scan_boitier.step1.port_occupe'.tr()
                                  : 'stepper_scan_boitier.step1.port_libre'.tr(),
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            if (port.cableSerialNumber != null)
                              Text(
                                port.cableSerialNumber.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontSize: 13),
                              ),
                          ]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: 0.7,
                            child: Switch.adaptive(
                              value: isUsed,
                              onChanged: (_) => controller.toggleOrScanPort(i),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // ← nouveau : bouton Détails
                          if (port.status == "used" &&
                              AppConstants.canAddClientData(
                                  controller.currentBoitier?.type))
                            IconButton(
                              icon: const Icon(Icons.info_outline),
                              tooltip:
                                  'stepper_scan_boitier.step2.view_details'.tr(),
                              onPressed: () async {
                                print("portportport");
                                print(port);
                                await controller.askClientInfo(
                                  context,
                                  port.cableSerialNumber ?? "",
                                  existingData: ClientInfo(
                                      cableCode: port.cableSerialNumber ?? "",
                                      clientName: port.clientName ?? "",
                                      clientPhone: port.clientPhone ?? "",
                                      latitude: port.latitude,
                                      longitude: port.longitude),
                                  isDetail: true,
                                );
                              }
                            ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }
}

// type == odp afficher client..
// type = bpeo comme les inputs/outputs..
