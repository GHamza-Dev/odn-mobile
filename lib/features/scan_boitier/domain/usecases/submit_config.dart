import '../entities/attachment.dart';
import '../entities/port.dart';
import '../repositories/scan_boitier_repo.dart';

class SubmitConfigurationUseCase {
  final ScanBoitierRepository repo;
  SubmitConfigurationUseCase(this.repo);
  Future<void> call({
    required Map<String, dynamic> payload,
    required List<String> filePaths,
  }) => repo.submitConfiguration(payload: payload,filePaths: filePaths);
}
