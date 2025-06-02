// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'port_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortModel _$PortModelFromJson(Map<String, dynamic> json) => PortModel(
      portNumber: (json['portNumber'] as num).toInt(),
      status: json['status'] as String,
      ontSerialNumber: json['ontSerialNumber'] as String?,
      cableSerialNumber: json['cableSerialNumber'] as String?,
      clientName: json['clientName'] as String?,
      clientPhone: json['clientPhone'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PortModelToJson(PortModel instance) => <String, dynamic>{
      'portNumber': instance.portNumber,
      'status': instance.status,
      'ontSerialNumber': instance.ontSerialNumber,
      'cableSerialNumber': instance.cableSerialNumber,
      'clientName': instance.clientName,
      'clientPhone': instance.clientPhone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
