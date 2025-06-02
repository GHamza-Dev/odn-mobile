// lib/features/tasks_map/data/models/feature_model.dart
import 'geometry_model.dart';

class FeatureModel {
  final GeometryModel geometry;
  final Map<String, dynamic> properties;

  FeatureModel({required this.geometry, required this.properties});

  factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(
    geometry: GeometryModel.fromJson(json['geometry'] as Map<String, dynamic>),
    properties: Map<String, dynamic>.from(json['properties'] as Map),
  );

  @override
  String toString() {
    return 'FeatureModel{geometry: $geometry, properties: $properties}';
  }
}
