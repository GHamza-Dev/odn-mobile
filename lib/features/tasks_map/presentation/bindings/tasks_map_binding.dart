import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:switch_config/features/tasks_map/domain/repositories/tasks_map_repository.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/tasks_map_remote_ds.dart';
import '../../data/repositories/tasks_map_repo_impl.dart';
import '../../domain/usecases/get_odn_geo_data_usecase.dart';
import '../controllers/tasks_map_controller.dart';

class TasksMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => dioClient);
    Get.lazyPut(() => TasksMapRemoteDataSource(Get.find()));
    Get.lazyPut<TasksMapRepository>(
          () => TasksMapRepositoryImpl(Get.find()),
    );
    Get.lazyPut(() => GetOdnGeoDataUseCase(Get.find()));
    Get.lazyPut(() => TasksMapController(Get.find()));
  }
}
