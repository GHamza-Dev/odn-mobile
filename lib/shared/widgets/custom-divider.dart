import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:switch_config/core/themes/app_colors.dart';

class CustomDivider extends StatelessWidget {
  Color? color;
  CustomDivider({this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 5,
      height: 10,
      color: color ?? AppColors.primary,
    );
  }
}
