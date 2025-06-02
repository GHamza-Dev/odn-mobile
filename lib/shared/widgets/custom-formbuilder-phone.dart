import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:get/get.dart';

import '../../core/themes/app_borders.dart';

class CustomIntlPhoneField extends StatelessWidget {
  dynamic numPhoneController;
  String? labelText;
  bool? disableLengthCheck;

  CustomIntlPhoneField(
      {required this.numPhoneController,
        this.labelText,
        this.disableLengthCheck});

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialCountryCode: "MA",
      showDropdownIcon: false,
      disableLengthCheck: disableLengthCheck ?? false,
      flagsButtonPadding: const EdgeInsets.only(left: 20),
      pickerDialogStyle: PickerDialogStyle(
          searchFieldPadding: EdgeInsets.all(0),
          searchFieldInputDecoration: InputDecoration(
            labelText: 'SEARCH_BY_COUNTRY_NAME'.tr,
            labelStyle: TextStyle(fontSize: 12),
          )),
      countries: countries.where((element) => element.code.contains('MA')).toList(),
      controller: numPhoneController,
      invalidNumberMessage: "INVALID_PHONE".tr,
      style: TextStyle(
          fontSize: 20,
          height: 1,
          letterSpacing: 2,
          color: Colors.black),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          counter: const SizedBox(),
          labelText: labelText?.tr ?? "NUM_TELEPHONE".tr,
          border: AppBorders.border(allWhite: false),
          enabledBorder: AppBorders.enabled(allWhite: false),
          focusedBorder: AppBorders.focused(allWhite: false),
          labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
          contentPadding: const EdgeInsets.all(0),
          prefixIcon:
          const Icon(Icons.padding, size: 20, color: Colors.black),
          alignLabelWithHint: true),
      textAlign: TextAlign.left,
      onChanged: (phone) {
        print(phone);
      },
    );
  }
}
