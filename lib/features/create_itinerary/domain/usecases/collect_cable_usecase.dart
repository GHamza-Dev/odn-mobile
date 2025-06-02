
import '../entities/coordinate.dart';
import '../repositories/create_itinerary_repository.dart';

class CollectCableUseCase {
  final CreateItineraryRepository _repo;
  CollectCableUseCase(this._repo);

  Future<void> call(String cableSn, List<Coordinate> coords) =>
      _repo.collectCable(cableSn: cableSn, coords: coords);
}
