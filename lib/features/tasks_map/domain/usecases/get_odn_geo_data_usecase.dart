import 'package:switch_config/features/tasks_map/data/models/odn_geo_data_model.dart';

import '../repositories/tasks_map_repository.dart';
import '../../data/models/feature_model.dart';

class GetOdnGeoDataUseCase {
  final TasksMapRepository _repo;
  GetOdnGeoDataUseCase(this._repo);

  Future<OdnGeoDataModel> call() => _repo.getOdnGeoData();
}
