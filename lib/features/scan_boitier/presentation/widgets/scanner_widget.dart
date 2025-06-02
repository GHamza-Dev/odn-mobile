import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/themes/app_colors.dart';

typedef OnDetect = void Function(String code);

class ScannerWidget extends StatelessWidget {
  final OnDetect onDetect;

  final String title;
  final String label;

  const ScannerWidget({super.key, required this.onDetect,required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: Text(title,
            style: const TextStyle(color: Colors.white)),
      ),
      body: Stack(children: [
        MobileScanner(
          onDetect: (capture) {
            final code = capture.barcodes.first.rawValue;
            if (code != null && code.isNotEmpty) {
              Get.back<String>(result: code);
            }
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            color: Colors.black54,
            padding: const EdgeInsets.all(12),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ]),
    );
  }
}
