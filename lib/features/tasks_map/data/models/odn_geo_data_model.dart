// lib/features/tasks_map/data/models/odn_geo_data_model.dart
import 'package:meta/meta.dart';
import 'feature_model.dart';

class OdnGeoDataModel {
  final List<FeatureModel> boitiers;
  final List<FeatureModel> cables;

  OdnGeoDataModel({
    required this.boitiers,
    required this.cables,
  });

  factory OdnGeoDataModel.fromJson(Map<String, dynamic> json) {
    final boitierJsonList = json['boitiers'] as List<dynamic>? ?? [];
    final cableJsonList   = json['cables']   as List<dynamic>? ?? [];

    return OdnGeoDataModel(
      boitiers: boitierJsonList
          .map((e) => FeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cables: cableJsonList
          .map((e) => FeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
