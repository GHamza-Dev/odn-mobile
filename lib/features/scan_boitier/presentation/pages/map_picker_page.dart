import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart' hide Trans;
import 'package:geolocator/geolocator.dart';
import 'package:switch_config/core/themes/app_colors.dart';

class MapPickerPage extends StatefulWidget {
  final LatLng initialPosition;
  const MapPickerPage({Key? key, required this.initialPosition})
      : super(key: key);

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  late LatLng _pickedPosition;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _pickedPosition = widget.initialPosition;
  }

  Future<void> _goToCurrentLocation() async {
    try {
      LocationPermission p = await Geolocator.checkPermission();
      if (p == LocationPermission.denied) {
        p = await Geolocator.requestPermission();
        if (p == LocationPermission.denied) return;
      }
      if (p == LocationPermission.deniedForever) {
        // permission bloquée définitivement
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final latlng = LatLng(pos.latitude, pos.longitude);
      setState(() {
        _pickedPosition = latlng;
      });

      _mapController.move(latlng, 16);
    } catch (e) {
      Get.snackbar('erreur'.tr(), 'stepper_scan_boitier.map.cannot_get_position'.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        leading: InkWell(
            onTap: ()=>Get.back(),
            child: BackButtonIcon()),
        backgroundColor: AppColors.primary,
        title: Text('stepper_scan_boitier.map.chosir_position'.tr(),
            style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Get.back<LatLng>(result: _pickedPosition),
            child: Text('confirm'.tr(), style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: widget.initialPosition,
          initialZoom: 16,
          onTap: (_, latlng) => setState(() {
            _pickedPosition = latlng;
          }),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _pickedPosition,
                width: 48,
                height: 48,
                child:const Icon(
                  Icons.location_on,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
