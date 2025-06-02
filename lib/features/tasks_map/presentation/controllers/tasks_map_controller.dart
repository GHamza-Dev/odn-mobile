import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart' hide Trans;
import 'package:switch_config/core/controllers/loading_controller.dart';
import 'package:switch_config/core/router/app_routes.dart';
import 'package:switch_config/core/themes/app_constants.dart';
import 'package:switch_config/features/scan_boitier/domain/entities/boitier.dart';
import 'package:switch_config/shared/widgets/custom-formbuilder-textfield.dart';
import '../../../../shared/widgets/uderlined-title.dart';
import '../../data/models/feature_model.dart';
import '../../data/models/odn_geo_data_model.dart';
import '../../domain/usecases/get_odn_geo_data_usecase.dart';

class TasksMapController extends GetxController {
  final GetOdnGeoDataUseCase _getGeo;
  TasksMapController(this._getGeo);
  final loadingCtrl = Get.find<LoadingController>();
  final boitiers = <FeatureModel>[].obs;  // liste des points
  final cables   = <FeatureModel>[].obs;  // liste des lignes
  final loading  = false.obs;

  Rxn<Boitier> passeportProduit = Rxn<Boitier>();

  @override
  void onInit() {
    super.onInit();
    _loadGeoData();
  }

  Future<void> _loadGeoData() async {
    // loading.value = true;
    try {
      final dto = await _getGeo();
      log(dto.toString());
      boitiers.assignAll(dto.boitiers);
      cables.assignAll(dto.cables);
      refresh();
    } finally {
      // loading.value = false;
    }
  }

  openDialogDetails(FeatureModel feature) async {
  }

}