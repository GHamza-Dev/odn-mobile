import '../../domain/entities/boitier.dart';
import '../../domain/entities/attachment.dart';
import '../../domain/entities/port.dart';
import '../../domain/repositories/scan_boitier_repo.dart';
import '../datasources/scan_boitier_remote_ds.dart';
import '../models/boitier_data_model.dart';
import '../models/port_model.dart';
import '../models/attachment_model.dart';

class ScanBoitierRepoImpl implements ScanBoitierRepository {
  final ScanBoitierRemoteDataSource ds;
  ScanBoitierRepoImpl(this.ds);

  @override
  Future<Boitier?> loadBoitierDetails(String type, String sn) async {
    final model = await ds.loadBoitierDetails(type,sn);
    return model?.toEntity();
  }
  @override
  Future<void> submitConfiguration({
    required Map<String, dynamic> payload,
    required List<String> filePaths,
  }) {
    return ds.submitConfiguration(payload: payload,filePaths: filePaths);
  }
}
