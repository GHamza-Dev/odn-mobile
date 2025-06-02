// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boitier_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoitierDataModel _$BoitierDataModelFromJson(Map<String, dynamic> json) =>
    BoitierDataModel(
      gid: (json['gid'] as num?)?.toInt(),
      serialNumber: json['serialNumber'] as String?,
      theoricalLosses: (json['theoricalLosses'] as num?)?.toDouble(),
      connectorization: json['connectorization'] as String?,
      connectorizationBody: json['connectorizationBody'] as String?,
      productionDate: json['productionDate'] == null
          ? null
          : DateTime.parse(json['productionDate'] as String),
      productionBatch: json['productionBatch'] as String?,
      origin: json['origin'] as String?,
      material: json['material'] as String?,
      warrantyDate: json['warrantyDate'] == null
          ? null
          : DateTime.parse(json['warrantyDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
      manufacturer: json['manufacturer'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      status: json['status'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      photo: json['photo'] as String?,
      numberOfPorts: (json['numberOfPorts'] as num?)?.toInt(),
      type: json['type'] as String?,
      numberOfInputs: (json['numberOfInputs'] as num?)?.toInt(),
      numberOfOutputs: (json['numberOfOutputs'] as num?)?.toInt(),
      cableDiameter: (json['cableDiameter'] as num?)?.toDouble(),
      input: json['input'] as String?,
      output: json['output'] as String?,
      ports: (json['ports'] as List<dynamic>?)
          ?.map((e) => PortModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BoitierDataModelToJson(BoitierDataModel instance) =>
    <String, dynamic>{
      'gid': instance.gid,
      'serialNumber': instance.serialNumber,
      'theoricalLosses': instance.theoricalLosses,
      'connectorization': instance.connectorization,
      'connectorizationBody': instance.connectorizationBody,
      'productionDate': instance.productionDate?.toIso8601String(),
      'productionBatch': instance.productionBatch,
      'origin': instance.origin,
      'material': instance.material,
      'warrantyDate': instance.warrantyDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'createdBy': instance.createdBy,
      'manufacturer': instance.manufacturer,
      'name': instance.name,
      'code': instance.code,
      'status': instance.status,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photo': instance.photo,
      'numberOfPorts': instance.numberOfPorts,
      'type': instance.type,
      'numberOfInputs': instance.numberOfInputs,
      'numberOfOutputs': instance.numberOfOutputs,
      'cableDiameter': instance.cableDiameter,
      'input': instance.input,
      'output': instance.output,
      'ports': instance.ports,
    };
