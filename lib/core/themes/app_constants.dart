import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AppConstants {


  static const String ODP_CODE = "odp";
  static const String BPEO = "BPEO";

  // type == odp afficher client..
// type = bpeo comme les inputs/outputs..

  static String? requiredFieldValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'validator_required'.tr();
    }
    return null;
  }



  static bool canAddClientData(String? type) {
    return type == ODP_CODE;
  }

}
