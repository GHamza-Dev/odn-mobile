import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Trans;

import '../controllers/loading_controller.dart';

String formatDate(DateTime? date) {
  if(date == null) return "";
  return DateFormat('dd/MM/yyyy').format(date);
}

Future<Position?> determinePosition(BuildContext ctx) async {
  final loader = Get.find<LoadingController>();
  loader.show();
  LocationPermission permission = await Geolocator.checkPermission();
  loader.hide();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await showDialog(
        context: ctx,
        builder: (_) => AlertDialog(
          title: Text('location_permission_required'.tr()),
          content: Text('location_permission_denied'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('ok'.tr()),
            )
          ],
        ),
      );
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        title: Text('location_permission_permanently_denied'.tr()),
        content: Text('location_permission_open_settings'.tr()),
        actions: [
          TextButton(
            onPressed: () {
              Geolocator.openAppSettings();
              Navigator.of(ctx).pop();
            },
            child: Text('open_settings'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('cancel'.tr()),
          )
        ],
      ),
    );
    return null;
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
