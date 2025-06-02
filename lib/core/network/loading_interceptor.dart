import 'package:dio/dio.dart';
import 'package:get/get.dart' as $get;
import '../controllers/loading_controller.dart';

class LoadingInterceptor extends Interceptor {
  final _loader = $get.Get.find<LoadingController>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _loader.show();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _loader.hide();
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    _loader.hide();
    handler.next(err);
  }
}
