// lib/features/create_itinerary/presentation/controllers/create_itinerary_controller.dart
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:switch_config/core/router/app_routes.dart';
import '../../../../core/controllers/loading_controller.dart';
import '../../../scan_boitier/presentation/widgets/scanner_widget.dart';
import '../../domain/entities/coordinate.dart';
import '../../domain/usecases/collect_cable_usecase.dart';

class CreateItineraryController extends GetxController {
  final CollectCableUseCase _collect;
  CreateItineraryController(this._collect);

  final RxnString cableSn  = RxnString();           // null ou SN scanné
  final RxList<Coordinate> coords = <Coordinate>[].obs;
  RxnString error = RxnString();
  final loader = Get.find<LoadingController>();

  Future<void> scanCable() async {
    final sn = await Get.bottomSheet<String>(
      Container(
        color: Colors.black,
        child: ScannerWidget(
          onDetect: (qr) {
            log(name:"RESULT =","qr scanned = $qr");
            Get.back<String>(result: qr);
          },
          title: 'create_itinirary.scan_qr_cable'.tr(),
          label: 'create_itinirary.scan_instruction'.tr(),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    if (sn != null && sn.isNotEmpty) cableSn.value = sn;
  }


  Future<void> addCurrentPosition() async {
    try {
      loader.show();
      final pos = await Geolocator.getCurrentPosition();
      coords.add(Coordinate(lat: pos.latitude, lng: pos.longitude));
      loader.hide();
    } catch (e) {
      loader.hide();
      error.value = e.toString();
    }
  }


  Future<void> submit() async {
    if (cableSn.value == null || coords.isEmpty) return;
    loader.show();
    try {
      await _collect(cableSn.value!, coords);
      loader.hide();
      Get.defaultDialog(
        title: 'Succès',
        middleText: 'Itinéraire enregistré',
        textConfirm: 'OK',
        onConfirm: () => Get.offAllNamed(Routes.home),
      );
    } catch (e) {
      loader.hide();
      error.value = e.toString();
      Get.snackbar('Erreur', error.value!);
    }
  }
}
