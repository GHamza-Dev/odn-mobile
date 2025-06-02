import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter/services.dart';
import 'package:switch_config/core/themes/app_borders.dart';


class CustomFormBuilderTextFieldPassword extends StatelessWidget {
  final String name;
  final String labelText;
  final FocusNode focusNode;
  final IconData icon;
  List<FormFieldValidator<String?>>? validators;
  bool? onlyNumber;
  String? initialValue;
  bool? readOnly;
  int? maxLength;
  bool? obscureValue;
  IconButton? suffixIcon;
  bool? isAllWhite;

  CustomFormBuilderTextFieldPassword(
      {required this.name,
      required this.labelText,
      required this.focusNode,
      required this.icon,
      this.validators,
      this.onlyNumber,
      this.initialValue,
      this.maxLength,
      this.obscureValue,
      this.suffixIcon,
      this.isAllWhite,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      readOnly: readOnly ?? false,
      name: name,
      initialValue: initialValue,
      obscureText: obscureValue??false,
      maxLength: maxLength,
      inputFormatters:
          onlyNumber != null ? [FilteringTextInputFormatter.digitsOnly] : [],
      keyboardType:
          onlyNumber != null ? TextInputType.number : TextInputType.text,
      validator: FormBuilderValidators.compose(validators ?? []),
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontSize: 13,
        color: isAllWhite != null ? Colors.white : Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: isAllWhite != null? Colors.transparent : Colors.white,
        labelText: labelText,
        errorStyle: const TextStyle(
          color: Color(0xffd32f2f),
          fontSize: 10,
        ),
        border: AppBorders.border(allWhite: isAllWhite ?? false),
        enabledBorder: AppBorders.enabled(allWhite: isAllWhite ?? false),
        focusedBorder: AppBorders.focused(allWhite: isAllWhite ?? false),
        labelStyle: TextStyle(
            fontSize: 13,
            // color: isAllWhite != null ? Colors.white : focusNode.hasFocus ? primaryColor : Colors.black),
            color: isAllWhite != null ? Colors.white : Colors.black),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: Icon(icon,
            size: 20,
            color:
            isAllWhite != null ? Colors.white : Colors.black),
            // isAllWhite != null ? Colors.white : focusNode.hasFocus ? primaryColor : Colors.black),
            // focusNode.hasFocus ? primaryColor : isAllWhite != null ? Colors.white : Colors.black),
        suffixIcon: suffixIcon!,),
    );
  }
}
