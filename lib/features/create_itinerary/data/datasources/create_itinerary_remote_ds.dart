
import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/coordinate_model.dart';

class CreateItineraryRemoteDataSource {
  final Dio dio;
  CreateItineraryRemoteDataSource(this.dio);


  Future<void> collectCable({
    required String cableSn,
    required List<CoordinateModel> coords,
  }) async {
    final url = '/api/odn/collect-cable/$cableSn';

    final body = coords.map((c) => c.toJson()).toList();
    await dio.put(url, data: jsonEncode(body),
        options: Options(contentType: 'application/json'));
  }
}
