import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/services.dart';
import 'package:switch_config/core/themes/app_borders.dart';
import 'package:switch_config/core/themes/app_colors.dart';

class CustomFormBuilderTextField extends StatelessWidget {
  final String name;
  final String labelText;
  final FocusNode focusNode;
  final IconData? icon;
  List<FormFieldValidator<String?>>? validators;
  bool? isPassword;
  bool? obscureValue;
  Function? onChange;
  bool? onlyNumber;
  bool? isPhoneNumber;
  String? initialValue;
  bool? readOnly;
  bool? autoFocus;
  int? maxLength;
  TextEditingController? controller;
  GlobalKey<FormBuilderState>? textFieldKey;
  bool? isAllWhite;
  bool enabled;
  int? minLines;
  int? maxLines;
  bool? centeredText;


  CustomFormBuilderTextField(
      {required this.name,
        required this.labelText,
        required this.focusNode,
        this.icon,
        this.validators,
        this.onlyNumber,
        this.isPhoneNumber,
        this.onChange,
        this.initialValue,
        this.readOnly,
        this.maxLength,
        this.controller,
        this.autoFocus,
        this.maxLines,
        this.minLines,
        this.enabled = true,
        this.isAllWhite = false,
        this.centeredText = false,
        this.textFieldKey});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      key: textFieldKey,
      textAlign: centeredText! ? TextAlign.center : TextAlign.start,
      onChanged: onChange != null ? (value) => onChange!(value) : null,
      controller: controller,
      autofocus: autoFocus ?? false,
      readOnly: readOnly ?? false,
      name: name,
      minLines: minLines ?? 1,
      maxLines: maxLines,
      enableInteractiveSelection: enabled,
      onTap: enabled == false ? () { FocusScope.of(context).requestFocus(FocusNode()); } : () {},
      initialValue: initialValue,
      maxLength: maxLength,
      inputFormatters: onlyNumber != null ? [FilteringTextInputFormatter.digitsOnly] : [],
      keyboardType:
      isPhoneNumber != null ? TextInputType.phone : onlyNumber != null ? TextInputType.number : (minLines != null ? TextInputType.multiline : TextInputType.text),
      obscureText: false,
      validator: FormBuilderValidators.compose(validators ?? []),
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        fontSize: 12,
      ),
      decoration: InputDecoration(
        counterText:"",
        filled: true,
        alignLabelWithHint: true,
        fillColor: (readOnly ?? false) ? Colors.grey.withOpacity(.2) : Colors.white,
        labelText: labelText,
        border: AppBorders.border(allWhite:isAllWhite),
        enabledBorder: AppBorders.enabled(allWhite:isAllWhite),
        focusedBorder: AppBorders.focused(allWhite:isAllWhite),
        errorStyle: const TextStyle(
          color: Color(0xffd32f2f),
          fontSize: 10,
        ),
        errorMaxLines: 3,
        labelStyle: TextStyle(
            fontSize: 13,
            color:  isAllWhite != false ? Colors.white : focusNode.hasFocus ? AppColors.primary : Colors.black),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: icon == null
            ? null
            : Icon(
          icon,
          size: 20,
          color: isAllWhite != false ? Colors.white : focusNode.hasFocus ? AppColors.primary : Colors.black,
        ),
      ),
      textInputAction : minLines != null ? TextInputAction.newline : TextInputAction.done,
    );
  }
}