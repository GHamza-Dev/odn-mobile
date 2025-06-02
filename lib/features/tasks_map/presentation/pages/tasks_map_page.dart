import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get/get.dart' hide Trans;
import 'package:latlong2/latlong.dart';
import 'package:switch_config/core/controllers/loading_controller.dart';
import 'package:switch_config/core/themes/app_colors.dart';
import 'package:switch_config/gen/assets.gen.dart';
import 'package:switch_config/shared/widgets/footer.dart';

import '../../../../core/utils/functions.dart';
import '../controllers/tasks_map_controller.dart';

class TasksMapPage extends GetView<TasksMapController> {
  final MapController _mapController = MapController();

  TasksMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Footer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("label_menu.cartographie".tr(),
            style: const TextStyle(color: Colors.white)),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // Centre initial : premier boitier ou fallback
        final boitiers = controller.boitiers;

        if(boitiers.isEmpty) return SizedBox.shrink();

        final initialCenter =  LatLng(
          (boitiers.first.geometry.coordinates[1] as num).toDouble(),
          (boitiers.first.geometry.coordinates[0] as num).toDouble(),
        );

        return Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: initialCenter,
                initialZoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                  'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
                CurrentLocationLayer(),
                // Les lignes (câbles)
                PolylineLayer(
                  polylines: controller.cables.map((f) {
                    final pts = (f.geometry.coordinates as List)
                        .map<LatLng>((pair) => LatLng(
                      (pair[1] as num).toDouble(),
                      (pair[0] as num).toDouble(),
                    ))
                        .toList();
                    return Polyline(
                      points: pts,
                      strokeWidth: 2,
                      color: Colors.black,
                      borderColor: Colors.red,
                    );
                  }).toList(),
                ),
                // Les marqueurs (boîtiers)
                MarkerLayer(
                  markers: boitiers.map((f) {
                    final coords = f.geometry.coordinates;
                    return Marker(
                      point: LatLng(
                        (coords[1] as num).toDouble(),
                        (coords[0] as num).toDouble(),
                      ),
                      width: 40,
                      height: 40,
                      child: InkWell(
                        onTap: () async => await controller.openDialogDetails(f),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(Assets.images.iconMarker.path),
                            )),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () async {
                  controller.loadingCtrl.show();
                  final position = await determinePosition(context);
                  if (position != null) {
                    _mapController.move(
                      LatLng(position.latitude, position.longitude),
                      15,
                    );
                  }
                  controller.loadingCtrl.hide();
                },
                child: const Icon(Icons.my_location),
              ),
            ),
          ],
        );
      }),
    );
  }
}