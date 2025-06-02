import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:switch_config/features/tasks_map/data/models/feature_model.dart';
import 'package:switch_config/gen/assets.gen.dart';
import '../../../../core/controllers/loading_controller.dart';
import '../../../../core/utils/functions.dart';

class TasksMapWidget extends StatefulWidget {
  final List<FeatureModel> boitiers;
  final List<FeatureModel> cables;

  const TasksMapWidget({
    super.key,
    required this.boitiers,
    required this.cables,
  });

  @override
  State<TasksMapWidget> createState() => _TasksMapWidgetState();
}

class _TasksMapWidgetState extends State<TasksMapWidget> {
  final MapController _mapController = MapController();
  late LatLng _initialCenter;
  bool _isInitializing = true;
  final _loadingController = Get.find<LoadingController>();

  @override
  void initState() {
    super.initState();
    _initializeMapCenter();
  }

  Future<void> _initializeMapCenter() async {
    try {
      if (widget.boitiers.isNotEmpty) {
        final coords = widget.boitiers.first.geometry.coordinates;
        _initialCenter = LatLng(
          (coords[1] as num).toDouble(),
          (coords[0] as num).toDouble(),
        );
      }
      else {
        _loadingController.show();
        final position = await determinePosition(Get.context!);
        _initialCenter = position != null
            ? LatLng(position.latitude, position.longitude)
            : const LatLng(33.528442, -7.645522); // Fallback
      }
    } catch (e) {
      _initialCenter = const LatLng(33.528442, -7.645522); // Fallback on error
    } finally {
      _loadingController.hide();
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _initialCenter,
            initialZoom: 13,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            CurrentLocationLayer(),
            PolylineLayer(
              polylines: widget.cables.map((f) {
                final points = (f.geometry.coordinates as List<dynamic>)
                    .map<LatLng>((pair) => LatLng(
                  (pair[1] as num).toDouble(),
                  (pair[0] as num).toDouble(),
                ))
                    .toList();
                return Polyline(
                  points: points,
                  strokeWidth: 2,
                  color: Colors.black,
                  borderColor: Colors.red,
                );
              }).toList(),
            ),
            MarkerLayer(
              markers: widget.boitiers.map((f) {
                final coords = f.geometry.coordinates;
                return Marker(
                  point: LatLng(
                    (coords[1] as num).toDouble(),
                    (coords[0] as num).toDouble(),
                  ),
                  width: 40,
                  height: 40,
                  child: Image.asset(Assets.images.iconMarker.path),
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
              // _loadingController.show();
              try {
                final location = await determinePosition(Get.context!);
                if (location != null) {
                  _mapController.move(
                    LatLng(location.latitude, location.longitude),
                    15,
                  );
                }
              } finally {
                // _loadingController.hide();
              }
            },
            child: const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}