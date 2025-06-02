import 'dart:convert';
import 'dart:developer';
import 'package:mime/mime.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:dio/dio.dart';
import 'package:switch_config/core/network/api_endpoints.dart';
import 'package:switch_config/features/scan_boitier/domain/entities/boitier.dart';
import '../models/boitier_data_model.dart';
import '../models/port_model.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

class ScanBoitierRemoteDataSource {
  final Dio dio;
  ScanBoitierRemoteDataSource(this.dio);

  Future<BoitierDataModel?> loadBoitierDetails(String type,String sn) async {
    log("type$type");
    log("sn$sn");
    final response = await dio.get(
      ApiEndPoints.GET_DETAILS_BOITIER,
      queryParameters: {
        'type': type,
        'sn'  : sn,
      },
    );
    print("response.data");
    log(name:"RESULT BOITIER > " , jsonEncode(response.data).toString());
    if(response.data != null && response.data != "")
      return BoitierDataModel.fromJson(response.data['data']);
    else
      return null;
  }


  Future<void> submitConfiguration({
    required Map<String, dynamic> payload,
    required List<String> filePaths,
  }) async {
    final reqJson = jsonEncode(payload['req']);
    print(reqJson);
    final formData = FormData();
    // formData.fields.add(MapEntry('req', jsonEncode(reqJson)));


    log("reqJson");
    log(name:"reqJson",reqJson.toString());

    formData.files.add(
      MapEntry(
        'req',
        MultipartFile.fromString(
          reqJson,
          // filename: 'blob',
          contentType: DioMediaType('application', 'json'),
        ),
      ),
    );


    for (final path in filePaths) {
      final filename = p.basename(path);
      final mimeType = lookupMimeType(path) ?? 'application/octet-stream';
      final parts = mimeType.split('/');
      final filePart = await MultipartFile.fromFile(
        path,
        filename: filename,
        contentType: DioMediaType(parts[0], parts[1]),
      );
      formData.files.add(MapEntry('files', filePart));
    }

    await dio.put(ApiEndPoints.SUBMIT, data: formData,);
  }
}
