import 'package:json_annotation/json_annotation.dart';
import 'port_model.dart';
import '../../domain/entities/boitier.dart';
import '../../domain/entities/port.dart';

part 'boitier_data_model.g.dart';

@JsonSerializable()
class BoitierDataModel {
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
  final List<PortModel>? ports;

  const BoitierDataModel({
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

  factory BoitierDataModel.fromJson(Map<String, dynamic> json) =>
      _$BoitierDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoitierDataModelToJson(this);
}

extension BoitierDataModelX on BoitierDataModel {
  Boitier toEntity() => Boitier(
    gid: gid,
    serialNumber: serialNumber,
    theoricalLosses: theoricalLosses,
    connectorization: connectorization,
    connectorizationBody: connectorizationBody,
    productionDate: productionDate,
    productionBatch: productionBatch,
    origin: origin,
    material: material,
    warrantyDate: warrantyDate,
    createdAt: createdAt,
    createdBy: createdBy,
    manufacturer: manufacturer,
    name: name,
    code: code,
    status: status,
    latitude: latitude,
    longitude: longitude,
    photo: photo,
    numberOfPorts: numberOfPorts,
    type: type,
    numberOfInputs: numberOfInputs,
    numberOfOutputs: numberOfOutputs,
    cableDiameter: cableDiameter,
    input: input,
    output: output,
    ports: ports
        ?.map((m) => Port(
      portNumber: m.portNumber,
      status: m.status,
      ontSerialNumber: m.ontSerialNumber,
      longitude: m.longitude,
      cableSerialNumber: m.cableSerialNumber,
      clientName: m.clientName,
      clientPhone: m.clientPhone,
      latitude: latitude
    ))
        .toList() ?? [],
  );
}