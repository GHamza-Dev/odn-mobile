// lib/features/scan_boitier/domain/entities/boitier.dart
import 'package:equatable/equatable.dart';
import 'port.dart';

class Boitier extends Equatable {
  final int? gid;
  final String? serialNumber;
  final double? theoricalLosses;
  final String? connectorization;
  final String? connectorizationBody;
  final DateTime? productionDate;
  final String? productionBatch;
  final String? origin;
  final String? material;
  final DateTime? warrantyDate;
  final DateTime? createdAt;
  final String? createdBy;
  final String? manufacturer;
  final String? name;
  final String? code;
  final String? status;
  final double? latitude;
  final double? longitude;
  final String? photo;
  final int? numberOfPorts;
  final String? type;
  final int? numberOfInputs;
  final int? numberOfOutputs;
  final double? cableDiameter;
  final String? input;
  final String? output;
  final List<Port>? ports;

  const Boitier({
    this.gid,
    this.serialNumber,
    this.theoricalLosses,
    this.connectorization,
    this.connectorizationBody,
    this.productionDate,
    this.productionBatch,
    this.origin,
    this.material,
    this.warrantyDate,
    this.createdAt,
    this.createdBy,
    this.manufacturer,
    this.name,
    this.code,
    this.status,
    this.latitude,
    this.longitude,
    this.photo,
    this.numberOfPorts,
    this.type,
    this.numberOfInputs,
    this.numberOfOutputs,
    this.cableDiameter,
    this.input,
    this.output,
    this.ports,
  });

  @override
  List<Object?> get props => [
    gid,
    serialNumber,
    theoricalLosses,
    connectorization,
    connectorizationBody,
    productionDate,
    productionBatch,
    origin,
    material,
    warrantyDate,
    createdAt,
    createdBy,
    manufacturer,
    name,
    code,
    status,
    latitude,
    longitude,
    photo,
    numberOfPorts,
    type,
    numberOfInputs,
    numberOfOutputs,
    cableDiameter,
    input,
    output,
    ports,
  ];
}