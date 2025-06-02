import '../entities/attachment.dart';
import '../entities/boitier.dart';
import '../entities/port.dart';

abstract class ScanBoitierRepository {
  Future<Boitier?> loadBoitierDetails(String type,String sn);
  Future<void> submitConfiguration({
    required Map<String, dynamic> payload,
    required List<String> filePaths,
  });
}
