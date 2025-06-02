
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/datasources/create_itinerary_remote_ds.dart';
import '../../data/repositories/create_itinerary_repo_impl.dart';
import '../../domain/repositories/create_itinerary_repository.dart';
import '../../domain/usecases/collect_cable_usecase.dart';
import '../controllers/create_itinerary_controller.dart';

class CreateItineraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio     >(()                      => dioClient);
    Get.lazyPut(()       => CreateItineraryRemoteDataSource(Get.find()));
    Get.lazyPut<CreateItineraryRepository>(
            () => CreateItineraryRepositoryImpl(Get.find()));
    Get.lazyPut(()       => CollectCableUseCase(Get.find()));
    Get.lazyPut(()       => CreateItineraryController(Get.find()));
  }
}
