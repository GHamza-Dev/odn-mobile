// lib/features/scan_boitier/domain/entities/port.dart
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class Port extends Equatable {
  final int portNumber;
  final String? status;
  final String? ontSerialNumber;
  final String? clientName;
  final String? clientPhone;
  final String? cableSerialNumber;
  final double? latitude;
  final double? longitude;

  const Port({
    required this.portNumber,
    this.status,
    this.ontSerialNumber,
    this.clientName,
    this.clientPhone,
    this.cableSerialNumber,
    this.latitude,
    this.longitude,
  });

  Port copyWith({
    required int? portNumber,
    String? status,
    String? ontSerialNumber,
    String? clientName,
    String? clientPhone,
    String? cableSerialNumber,
    double? latitude,
    double? longitude,
  }) {
    return Port(
      portNumber: portNumber ?? this.portNumber,
      status: status,
      ontSerialNumber: ontSerialNumber,
      clientName: clientName,
      clientPhone: clientPhone,
      cableSerialNumber: cableSerialNumber,
      latitude: latitude,
      longitude: longitude
    );
  }

  @override
  List<Object?> get props => [
    portNumber,
    status,
    ontSerialNumber,
    clientName,
    clientPhone,
    cableSerialNumber,
    latitude,
    longitude
  ];
}
