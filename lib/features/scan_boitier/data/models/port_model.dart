// lib/features/scan_boitier/data/models/port_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'port_model.g.dart';

@JsonSerializable()
class PortModel {
  @JsonKey(name: 'portNumber')
  final int portNumber;
  final String status;
  @JsonKey(name: 'ontSerialNumber')
  final String? ontSerialNumber;

  final String? cableSerialNumber;
  final String? clientName;
  final String? clientPhone;
  final double? latitude;
  final double? longitude;


  const PortModel({
    required this.portNumber,
    required this.status,
    this.ontSerialNumber,
    this.cableSerialNumber,
    this.clientName,
    this.clientPhone,
    this.latitude,
    this.longitude,
  });

  factory PortModel.fromJson(Map<String, dynamic> json) =>
      _$PortModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortModelToJson(this);
}
