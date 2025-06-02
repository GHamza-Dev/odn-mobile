import 'package:flutter/material.dart';
import 'package:switch_config/core/themes/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String btnTxt;
  final VoidCallback btnFn;
  final double? width;
  final bool showIcon;
  final bool iconLeft;
  final Widget? icon;
  final bool isSecondary;
  final bool isDisabled;
  final Color? backgroundColor;
  final double elevation;
  final double fontSize;

  const CustomButtonWidget({
    Key? key,
    required this.btnTxt,
    required this.btnFn,
    this.width,
    this.showIcon = true,
    this.iconLeft = true,
    this.icon,
    this.isSecondary = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.elevation = 4.0,
    this.fontSize = 13.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ??
        (isSecondary ? AppColors.secondary : AppColors.primary);

    return SizedBox(
      width: width ?? 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: elevation,
        ),
        onPressed: isDisabled ? null : btnFn,
        child: showIcon && icon != null
            ? Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          child: Row(
            children: [
              // Icône (flex 0)
              if (iconLeft) Flexible(flex: 0, child: icon!),
              if (iconLeft) const SizedBox(width: 8),

              // Texte centré (flex 1)
              Expanded(
                flex: 1,
                child: Text(
                  btnTxt,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                ),
              ),

              if (!iconLeft) const SizedBox(width: 8),
              // Icône à droite (flex 0)
              if (!iconLeft) Flexible(flex: 0, child: icon!),
            ],
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            btnTxt,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
