
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:switch_config/core/storage/token_storage.dart';
import '../models/feature_model.dart';
import '../models/odn_geo_data_model.dart';

class TasksMapRemoteDataSource {
  final Dio _dio;
  TasksMapRemoteDataSource(this._dio);

  Future<OdnGeoDataModel> fetchOdnGeoData() async {
    final token = await SecureTokenStorage.read();
    if (token == null) throw Exception('No auth token found');

    final res = await _dio.get(
      '/api/odn/user-geo-data',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final data = res.data as Map<String, dynamic>;
    return OdnGeoDataModel.fromJson(data);
  }

}
