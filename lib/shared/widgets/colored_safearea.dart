import 'package:flutter/material.dart';
import 'package:switch_config/core/themes/app_colors.dart';


class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  const ColoredSafeArea({Key? key, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: child,
      ),
    );
  }
}