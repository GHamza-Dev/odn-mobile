import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

const borderColor = Color(0xFFd9a300);
const iconColor = Color(0xFF6d5100);

class Warning extends StatelessWidget {
  String? title;
  IconData icon;
  Color color;
  Warning({this.title,this.icon=Icons.info_outline,this.color = borderColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: color != borderColor ? color : borderColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              )),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              margin:EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFffecb3),
                borderRadius:  BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 0,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            icon,
                            color: color != borderColor ? color : iconColor,
                          ))),
                  Expanded(
                      flex: 1,
                      child: Text(
                        title ?? "no_data_found".tr(),
                        style: TextStyle(
                            fontSize: 11,
                           ),
                      )),
                ],
              )),
        )
      ],
    );
  }
}
