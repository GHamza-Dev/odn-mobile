import 'package:get/get.dart';

class LoadingController extends GetxController {
  final _count = 0.obs;

  bool get isLoading => _count.value > 0;

  void show() => _count.value++;
  void hide() {
    if (_count.value > 0) _count.value--;
  }
}
