
import '../../domain/entities/coordinate.dart';
import '../../domain/repositories/create_itinerary_repository.dart';
import '../datasources/create_itinerary_remote_ds.dart';
import '../models/coordinate_model.dart';

class CreateItineraryRepositoryImpl implements CreateItineraryRepository {
  final CreateItineraryRemoteDataSource _remote;
  CreateItineraryRepositoryImpl(this._remote);

  @override
  Future<void> collectCable({
    required String cableSn,
    required List<Coordinate> coords,
  }) {

    final models = coords.map((e) => CoordinateModel(lat: e.lat, lng: e.lng)).toList();
    return _remote.collectCable(cableSn: cableSn, coords: models);
  }
}
