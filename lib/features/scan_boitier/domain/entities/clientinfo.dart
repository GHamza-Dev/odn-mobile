import 'package:latlong2/latlong.dart';

class ClientInfo {
  final String cableCode;
  final String? clientName;
  final String? clientPhone;
  final double? latitude;
  final double? longitude;

  ClientInfo({
    required this.cableCode,
    this.clientName,
    this.clientPhone,
    this.latitude,
    this.longitude,
  });
}