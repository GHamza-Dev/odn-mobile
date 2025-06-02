// lib/features/tasks_map/data/models/geometry_model.dart
class GeometryModel {
  final String type;
  final dynamic coordinates; // Point: [lon,lat], LineString: [[lon,lat],...]

  GeometryModel({required this.type, required this.coordinates});

  factory GeometryModel.fromJson(Map<String, dynamic> json) => GeometryModel(
    type: json['type'] as String,
    coordinates: json['coordinates'],
  );

  @override
  String toString() {
    return 'GeometryModel{type: $type, coordinates: $coordinates}';
  }
}
