import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:switch_config/features/home/data/datasources/home_datasource.dart';
import 'package:switch_config/features/home/data/repositories/home_repository_impl.dart';
import 'package:switch_config/features/home/domain/repositories/home_repository.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final dio = Get.find<Dio>();
    Get.lazyPut(() => HomeRemoteDataSource(dio));
    Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.put(HomeController(Get.find()));
  }
}
