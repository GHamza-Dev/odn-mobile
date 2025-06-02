
class CoordinateModel {
  final double lat;
  final double lng;

  CoordinateModel({required this.lat, required this.lng});

  factory CoordinateModel.fromJson(Map<String,dynamic> json) => CoordinateModel(
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };
}
