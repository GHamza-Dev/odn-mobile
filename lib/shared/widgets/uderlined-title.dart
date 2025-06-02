import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom-divider.dart';

class UnderlinedTitle extends StatelessWidget {
  String title;
  bool? isCenteredUnderline = false;
  Color? textColor;
  Color? underlineColor;
  double? fontSize;
  UnderlinedTitle(
      {required this.title,
      this.isCenteredUnderline,
      this.textColor,
      this.fontSize,
      this.underlineColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: isCenteredUnderline == true
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: isCenteredUnderline == true
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: textColor,
              fontSize : fontSize,
          ),
        ),
        Container(
            width: 30,
            child: underlineColor != null
                ? CustomDivider(color: underlineColor)
                : CustomDivider()),
      ],
    );
  }
}
