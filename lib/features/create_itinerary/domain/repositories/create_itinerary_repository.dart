
import '../entities/coordinate.dart';

abstract class CreateItineraryRepository {
  Future<void> collectCable({
    required String cableSn,
    required List<Coordinate> coords,
  });
}
