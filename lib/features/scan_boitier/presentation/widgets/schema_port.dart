import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:switch_config/features/scan_boitier/domain/entities/boitier.dart';
import 'package:switch_config/features/scan_boitier/domain/entities/port.dart';

import '../../../../core/themes/app_constants.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../shared/widgets/custom-formbuilder-textfield.dart';
import '../../../../shared/widgets/uderlined-title.dart';

class SchemaPorts extends StatelessWidget {
  final Boitier? produit;
  const SchemaPorts({Key? key, required this.produit}) : super(key: key);

  static const _portPositions = <Map<String, dynamic>>[
    {'idx': 0, 'top': 58.0, 'left': 55.0},
    {'idx': 1, 'top': 62.0, 'left': 83.0},
    {'idx': 2, 'top': 62.0, 'right': 83.0},
    {'idx': 3, 'top': 58.0, 'right': 55.0},
    {'idx': 4, 'top': 30.0, 'left': 60.0},
    {'idx': 5, 'top': 35.0, 'left': 87.0},
    {'idx': 6, 'top': 35.0, 'right': 87.0},
    {'idx': 7, 'top': 30.0, 'right': 60.0},
  ];

  @override
  Widget build(BuildContext context) {
    final ports = produit?.ports ?? <dynamic>[];
    final inputs = produit?.numberOfInputs ?? 0;
    final outputs = produit?.numberOfOutputs ?? 0;

    String assetPath;
    if (inputs > 0 && outputs > 0) {
      assetPath = Assets.images.cableSchema.path;
    } else if (inputs > 0) {
      assetPath = Assets.images.cableSchema.path;
    } else if (outputs > 0) {
      assetPath = Assets.images.cableSchema.path;
    } else {
      assetPath = Assets.images.cableSchema.path;
    }

    final portWidgets = _portPositions.map<Widget>((pos) {
      final idx = pos['idx'] as int;
      Port port = ports[idx];
      final status = (ports.length > idx) ? port.status : null;
      final color = status == 'used' ? Colors.red : Colors.grey;
      return Positioned(
        top: pos['top'] as double,
        left: pos['left'] as double?,
        right: pos['right'] as double?,
        child: InkWell(
          onTap: (){
            if(port.status == "unused"){
              Get.snackbar(
                'message'.tr(),
                'passeport_produit.labels.port_x_libre'.tr(
                  namedArgs: {
                    'portNumber': "N° ${port.portNumber.toString()}"
                  },
                ),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: color,
                colorText: Colors.white,
              );
            }
            else{
              _openModalDetails(port);
            }
          },
          child: CircleAvatar(
            radius: 10,
            backgroundColor: color,
            child: Text('${idx + 1}', style: const TextStyle(fontSize: 12)),
          ),
        ),
      );
    }).toList();

    final extra = <Widget>[];
    if (inputs > 0) {
      extra
          .add(_inOutWidget('IN', 50, right: 175, isIn: true,));
    }
    if (outputs > 0) {
      extra.add(
          _inOutWidget('OUT', 50, left: 169, isIn: false));
    }

    return SizedBox(
      width: 500,
      height: 125,
      child: Stack(
        children: [
          Image.asset(assetPath, width: 500, height: 125, fit: BoxFit.cover),
          ...portWidgets,
          ...extra,
        ],
      ),
    );
  }

  Positioned _inOutWidget(String label, double top,
      {double? left, double? right, required bool isIn}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: InkWell(
        onTap: (){
          Get.snackbar(
            'message'.tr(),
            (isIn ? produit?.input != null : produit?.output != null) ?
            ('passeport_produit.labels.serialnumber'.tr() + " : ${isIn ? produit?.input : produit?.output}")
              :
            'passeport_produit.labels.port_x_libre'.tr(
            namedArgs: {
            'portNumber': isIn ? "IN" : "OUT"}),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: (isIn ? produit?.input != null : produit?.output != null) ? Colors.red : Colors.grey,
            colorText: Colors.white,
          );
        },
        child: CircleAvatar(
          radius: 13,
          backgroundColor: (isIn ? produit?.input != null : produit?.output != null) ? Colors.red : Colors.grey,
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }

  void _openModalDetails(Port port) {

    showDialog<void>(
      context: Get.context!,
      useSafeArea: true,
      builder: (ctx) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        insetPadding: EdgeInsets.all(10),
        title: Text('passeport_produit.client_info_title'.tr()),
        content: StatefulBuilder(
          builder: (ctx2, setState) {
            return SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomFormBuilderTextField(
                      focusNode: FocusNode(),
                      labelText:
                      'stepper_scan_boitier.step2.cable_associe'.tr(),
                      name: 'cableName',
                      icon: Icons.info,
                      validators: [AppConstants.requiredFieldValidator],
                      initialValue: port.cableSerialNumber,
                      readOnly: true,
                    ),
                    const SizedBox(height: 12),

                    // 2) Nom du client
                    CustomFormBuilderTextField(
                      focusNode: FocusNode(),
                      initialValue: port.clientName,
                      labelText: 'stepper_scan_boitier.step2.client_name'.tr(),
                      name: 'nomClient',
                      readOnly: true,
                      icon: Icons.person,
                      validators: [AppConstants.requiredFieldValidator],
                    ),

                    const SizedBox(height: 12),

                    // 3) Téléphone
                    CustomFormBuilderTextField(
                      focusNode: FocusNode(),
                      readOnly: true,
                      labelText: 'stepper_scan_boitier.step2.client_phone'.tr(),
                      name: 'telephoneClient',
                      initialValue: port.clientPhone,
                      icon: Icons.phone,
                      isPhoneNumber: true,
                      maxLength: 10,
                      validators: [
                        AppConstants.requiredFieldValidator,
                      ],
                    ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UnderlinedTitle(
                                title:
                                'stepper_scan_boitier.map.coors_gps'.tr()),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                '${'stepper_scan_boitier.map.latitude'.tr()} : ${port?.latitude}',
                                style: const TextStyle(fontSize: 14)),
                            Text(
                                '${'stepper_scan_boitier.map.longitude'.tr()} : ${port?.longitude}',
                                style: const TextStyle(fontSize: 14)),
                            // Text(gps.value, style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                  ],
                ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('cancel'.tr()),
          ),
        ],
      ),
    );
    return;
  }
}
