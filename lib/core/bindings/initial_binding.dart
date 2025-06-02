import 'package:get/get.dart';
import '../controllers/loading_controller.dart';
import '../network/dio_client.dart';
import '../network/loading_interceptor.dart';
import '../router/app_routes.dart';
import '../storage/token_storage.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoadingController(), permanent: true);
    dioClient.interceptors.add(LoadingInterceptor());
    Get.put(dioClient, permanent: true);
  }
}
