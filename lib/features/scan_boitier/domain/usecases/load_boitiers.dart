import '../entities/boitier.dart';
import '../repositories/scan_boitier_repo.dart';

class LoadBoitierDetailsUseCase {
  final ScanBoitierRepository repo;
  LoadBoitierDetailsUseCase(this.repo);
  Future<Boitier?> call(String type,String sn) => repo.loadBoitierDetails(type,sn);
}
