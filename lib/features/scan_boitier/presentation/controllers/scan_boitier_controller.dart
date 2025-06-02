import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:switch_config/core/controllers/loading_controller.dart';
import 'package:switch_config/core/router/app_routes.dart';
import 'package:switch_config/core/themes/app_constants.dart';
import 'package:switch_config/features/scan_boitier/domain/entities/boitier.dart';
import 'package:switch_config/features/scan_boitier/domain/entities/clientinfo.dart';
import 'package:switch_config/features/scan_boitier/presentation/widgets/scanner_widget.dart';
import 'package:switch_config/shared/widgets/custom-button.dart';
import 'package:switch_config/shared/widgets/custom-formbuilder-phone.dart';
import '../../../../core/utils/functions.dart';
import '../../../../shared/widgets/custom-formbuilder-textfield.dart';
import '../../../../shared/widgets/uderlined-title.dart';
import '../../domain/usecases/load_boitiers.dart';
import '../../domain/usecases/submit_config.dart';
import '../../domain/entities/attachment.dart';
import '../../domain/entities/port.dart';
import '../pages/map_picker_page.dart';

class ScanBoitierController extends GetxController {
  final LoadBoitierDetailsUseCase _loadDetails;
  final SubmitConfigurationUseCase _submitConfig;

  ScanBoitierController(this._loadDetails, this._submitConfig);

  final formKey = GlobalKey<FormBuilderState>();
  Rxn<LatLng> gps = Rxn<LatLng>();

  final boitier = <String, String>{}.obs;
  RxList<Port> ports = <Port>[].obs;
  final step = 0.obs; // 0 = scan boîtier, 1 = ports, 2 = doc
  final comment = ''.obs;
  final photos = <Attachment>[].obs;
  final loading = false.obs;
  Boitier? currentBoitier;
  RxList<dynamic> inOutPorts = [].obs;
  Rxn<Boitier> passeportProduit = Rxn<Boitier>();


  final inputSerialNumber = "".obs;
  final outputSerialNumber = "".obs;

  Future<void> scanQrCode({isPasseport = false}) async {
    final code = await Get.bottomSheet<String>(
      Container(
        color: Colors.black,
        child: ScannerWidget(
          onDetect: (qr) {
            log(name:"RESULT =","qr scanned = $qr");
            Get.back<String>(result: qr);
          },
          title: 'stepper_scan_boitier.step1.btn_scan'.tr(),
          label: 'stepper_scan_boitier.step1.scan_instruction'.tr(),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    print("code$code");
    if (code != null && code.isNotEmpty) {
      try {
        if (code == null || code.isEmpty) {
          throw Exception('Échec du scan : aucun code QR valide reçu.');
        }
        boitier.value = {"type":"odp","sn":code.toString()};
        print("boitier.value");
        print(boitier.value);
        var b = await loadPorts();
        if(b !=null){
          if(isPasseport) {
            passeportProduit.value = b;
          }
          else {
            currentBoitier = b;
            print("currentBoitier>>");
            print(currentBoitier.toString());
            passeportProduit.value = b;
            inputSerialNumber.value = currentBoitier?.input ?? "";
            outputSerialNumber.value = currentBoitier?.output ?? "";
            ports.assignAll(b.ports!);
            // step.value = 1;
          }
        }
        else{
          throw Exception();
        }
      } on FormatException catch (e) {
        Get.snackbar(
          'error'.tr(),
          'Invalid QR Code: ${e.message}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          'message'.tr(),
          'error_boitier_not_found'.tr(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  Future<Boitier?> loadPorts() async {
    loading.value = true;
    // try {
      print("boitier.value");
      print(boitier.value["type"]);
      print("boitier.value");
      Boitier? b = await _loadDetails(boitier.value["type"]!, boitier.value["sn"]!);
      return b;
      print("loadPorts result");
      print(b.toString());
    // } catch (e) {
    //   print("errroooooorr");
    //   print(e);
    //   return null;
    // } finally {
    //   loading.value = false;
    // }
  }

  Future<void> submit() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    loading.value = true;
    try {
      // final reqJson = jsonEncode(payload['req']);

      final currentPosition = await determinePosition(Get.context!);

      final odp = <String, dynamic>{
        'serialNumber': currentBoitier?.serialNumber ?? "",
        'latitude': currentPosition!.latitude,
        'longitude': currentPosition.longitude,
        'comment': comment.value,
        'input': inputSerialNumber.value,
        'output': outputSerialNumber.value,
      };

      print("odp===");
      print(odp);

      final clients = ports.value
      .where((p)=>p.status == "used")
          .map((p) => <String, dynamic>{
                'serialNumber': null, //// FOR FUTURE !!
                'clientName': p.clientName,
                'clientPhone': p.clientPhone,
                'clientAddress': "",
                'latitude': p.latitude,
                'longitude': p.longitude,
                'portNumber': p.portNumber,
                'dropCableSn': p.cableSerialNumber,
              })
          .toList();

    print("clients===");
    print(clients);
    print(odp);


    final files = photos.map((a) => a.path).toList();

      await _submitConfig(
        filePaths: files,
        payload: {
          'req': {
            'odp': odp,
            'clients': clients,
          },
        },
      );



      Get.snackbar(
        'success'.tr(),
        "stepper_scan_boitier.step3.creation_done".tr(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );



      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(Routes.home);
      });

    } catch (e) {
      Get.snackbar('erreur'.tr(), e.toString());
    } finally {
      loading.value = false;
    }
  }

  // void togglePort(int idx) {
  //   onScanCable(idx);
  //   final p = ports[idx];
  //   ports[idx] = Port(
  //     portNumber: p.portNumber,
  //     status: p.status.toLowerCase() == 'used' ? 'unused' : 'used',
  //     ontSerialNumber: p.ontSerialNumber,
  //   );
  // }

  Future<void> toggleOrScanPort(int idx) async {
    gps = Rxn<LatLng>();
    final p = ports[idx];

    if (p.status?.toLowerCase() == 'used') {
      ports[idx] = p.copyWith(
          portNumber: p.portNumber,
          status: 'unused',
          ontSerialNumber: null,
          clientName: null,
          clientPhone: null,
          latitude: null,
      longitude: null);
      return;
    }

    final result = await Get.bottomSheet<String>(
      SizedBox(
        height: Get.height,
        child: ScannerWidget(
          onDetect: (qr) => Get.back<String>(result: qr),
          title: 'stepper_scan_boitier.step2.btn_scan_codebare_cable'.tr(),
          label:
              'stepper_scan_boitier.step2.scan_instruction_codebare_cable'.tr(),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    if (result == null || result.isEmpty) return;

    // final Map<String, dynamic> data = jsonDecode(result);
    // final String? sn = data['sn'] as String?;

    if(AppConstants.canAddClientData(currentBoitier?.type)){
      final info = await askClientInfo(Get.context!, result);
      if (info == null) return;

      ports[idx] = p.copyWith(
        status: 'used',
        portNumber: ports[idx].portNumber,
        ontSerialNumber: "",
        cableSerialNumber: result,
        clientName: info['name'],
        clientPhone: info['phone'],
        latitude: gps.value?.latitude,
        longitude: gps.value?.longitude,
      );
      gps = Rxn<LatLng>();
    }
    else{
      ports[idx] = p.copyWith(
        portNumber: ports[idx].portNumber,
        status: 'used',
        ontSerialNumber: result,
        clientName:"",
        clientPhone: "",
        latitude: null,
        longitude: null,
      );
      gps = Rxn<LatLng>();
    }
  }

  void addPhoto(String path) => photos.add(Attachment(path));
  void setComment(String txt) => comment.value = txt;

  void removePhotoAt(int idx) {
    photos.removeAt(idx);
  }

  Future<Map<String, String>?> askClientInfo(
      BuildContext context, String cableCode,
      {bool isDetail = false, ClientInfo? existingData}) {

    return showDialog<Map<String, String>>(
      context: context,
      useSafeArea: true,
      builder: (ctx) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        insetPadding: EdgeInsets.all(10),
        title: Text('stepper_scan_boitier.step2.client_info_title'.tr()),
        content: StatefulBuilder(
          builder: (ctx2, setState) {
            return SingleChildScrollView(
              child: FormBuilder(
                key: formKey,
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
                      initialValue: cableCode, // pas besoin de jsonEncode
                      readOnly: true,
                    ),
                    const SizedBox(height: 12),

                    // 2) Nom du client
                    CustomFormBuilderTextField(
                      focusNode: FocusNode(),
                      initialValue: isDetail ? existingData?.clientName : "",
                      labelText: 'stepper_scan_boitier.step2.client_name'.tr(),
                      name: 'nomClient',
                      readOnly: isDetail,
                      icon: Icons.person,
                      validators: [AppConstants.requiredFieldValidator],
                    ),
                    const SizedBox(height: 12),

                    // 3) Téléphone
                    CustomFormBuilderTextField(
                      focusNode: FocusNode(),
                      readOnly: isDetail,
                      labelText: 'stepper_scan_boitier.step2.client_phone'.tr(),
                      name: 'telephoneClient',
                      initialValue: isDetail ? existingData?.clientPhone : "",
                      icon: Icons.phone,
                      isPhoneNumber: true,
                      maxLength: 10,
                      validators: [
                        AppConstants.requiredFieldValidator,
                        FormBuilderValidators.minLength(
                          10,
                          errorText:
                              'stepper_scan_boitier.step2.error_phone'.tr(),
                        ),
                      ],
                    ),

                    if (!isDetail)
                      Obx(() {
                        if (gps.value == null) {
                          return const SizedBox(
                            height: 16,
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UnderlinedTitle(
                                  title: 'stepper_scan_boitier.map.coors_gps'
                                      .tr()),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  '${'stepper_scan_boitier.map.latitude'.tr()} : ${gps.value!.latitude}',
                                  style: const TextStyle(fontSize: 14)),
                              Text(
                                  '${'stepper_scan_boitier.map.longitude'.tr()} : ${gps.value!.longitude}',
                                  style: const TextStyle(fontSize: 14)),
                              // Text(gps.value, style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        );
                      })
                    else
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
                                '${'stepper_scan_boitier.map.latitude'.tr()} : ${existingData?.latitude}',
                                style: const TextStyle(fontSize: 14)),
                            Text(
                                '${'stepper_scan_boitier.map.longitude'.tr()} : ${existingData?.longitude}',
                                style: const TextStyle(fontSize: 14)),
                            // Text(gps.value, style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),

                    if (!isDetail)
                      Row(
                        children: [
                          Expanded(
                            child: CustomButtonWidget(
                              btnTxt: 'stepper_scan_boitier.step2.get_gps'.tr(),
                              btnFn: () async {
                                FocusScope.of(context).unfocus();
                                // 1) Détermine la position actuelle
                                final pos = await determinePosition(ctx2);
                                if (pos == null) return;

                                // 2) Ouvre MapPickerPage
                                final choosen = await Get.to<LatLng>(
                                  () => MapPickerPage(
                                      initialPosition:
                                          LatLng(pos.latitude, pos.longitude)),
                                  fullscreenDialog: true,
                                );

                                // 3) Si valide, met à jour gps
                                if (choosen != null) {
                                  print("choosen");
                                  print(choosen);
                                  gps.value = choosen;
                                }
                              },
                              icon: const Icon(Icons.my_location,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('cancel'.tr()),
          ),
          if (!isDetail)
            TextButton(
              onPressed: () {
                if (formKey.currentState?.saveAndValidate() == false) return;

                if (gps.value == null) {
                  Get.snackbar(
                    'erreur'.tr(),
                    "stepper_scan_boitier.map.error_choose_position".tr(),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.shade700,
                    colorText: Colors.white,
                  );
                  return;
                }

                print(formKey.currentState!.value['nomClient'] as String);
                print(formKey.currentState!.value['telephoneClient'] as String);
                print(gps.value);

                Navigator.of(ctx).pop({
                  'name': formKey.currentState!.value['nomClient'] as String,
                  'phone':
                      formKey.currentState!.value['telephoneClient'] as String,
                });
              },
              child: Text('confirm'.tr()),
            ),
        ],
      ),
    );
  }

  Future<void> toggleOrScanInputOutput(bool isInput) async {

    if (isInput) {
      if(inputSerialNumber.value != ""){
        inputSerialNumber.value = "";
      return;
    }
    }
    else{
      if(outputSerialNumber.value != ""){
        outputSerialNumber.value = "";
        return;
      }

    }

    final qr = await Get.bottomSheet<String>(
      SizedBox(
        height: Get.height,
        child: ScannerWidget(
          onDetect: (qr) => Get.back<String>(result: qr),
          title: 'stepper_scan_boitier.step2.btn_scan_codebare_cable'.tr(),
          label:
          'stepper_scan_boitier.step2.scan_instruction_codebare_cable'.tr(),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    print("scnaed qr calbe => $qr");

    if (qr != null && qr.isNotEmpty) {
      if(isInput) {
        inputSerialNumber.value = qr;
      } else {
        outputSerialNumber.value = qr;
      }
    }
  }

}
