import 'package:switch_config/features/tasks_map/data/models/odn_geo_data_model.dart';

import '../../data/models/feature_model.dart';

abstract class TasksMapRepository {
  Future<OdnGeoDataModel> getOdnGeoData();
}
