import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:switch_config/features/home/domain/usecases/logout_usecase.dart';
import '../../data/datasources/auth_remote_ds.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../domain/usecases/login_usecase.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    final dio = Get.find<Dio>();
    Get.lazyPut(() => AuthRemoteDataSource(dio));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.put(AuthController(Get.find()));
  }
}