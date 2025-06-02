import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../data/datasources/scan_boitier_remote_ds.dart';
import '../../data/repositories/scan_boitier_repo_impl.dart';
import '../../domain/repositories/scan_boitier_repo.dart';
import '../../domain/usecases/load_boitiers.dart';
import '../../domain/usecases/submit_config.dart';
import '../controllers/scan_boitier_controller.dart';
import '../../../../core/network/dio_client.dart';

class ScanBoitierBinding extends Bindings {
  @override
  void dependencies() {
    final dio = Get.find<Dio>();
    Get.lazyPut(() => ScanBoitierRemoteDataSource(dio));
    Get.lazyPut<ScanBoitierRepository>(() => ScanBoitierRepoImpl(Get.find()));
    Get.lazyPut(() => LoadBoitierDetailsUseCase(Get.find()));
    Get.lazyPut(() => SubmitConfigurationUseCase(Get.find()));
    Get.put(ScanBoitierController(
      Get.find(), Get.find(),
    ));
  }
}
