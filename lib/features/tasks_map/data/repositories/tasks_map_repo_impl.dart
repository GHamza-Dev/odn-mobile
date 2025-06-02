import 'package:switch_config/features/tasks_map/data/models/odn_geo_data_model.dart';

import '../../domain/repositories/tasks_map_repository.dart';
import '../datasources/tasks_map_remote_ds.dart';
import '../models/feature_model.dart';

class TasksMapRepositoryImpl implements TasksMapRepository {
  final TasksMapRemoteDataSource _remote;
  TasksMapRepositoryImpl(this._remote);

  @override
  Future<OdnGeoDataModel> getOdnGeoData() =>
      _remote.fetchOdnGeoData();
}
