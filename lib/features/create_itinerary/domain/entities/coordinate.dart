
import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  final double lat;
  final double lng;

  const Coordinate({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];
}
