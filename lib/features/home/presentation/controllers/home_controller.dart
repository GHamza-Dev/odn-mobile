import 'package:get/get.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/usecases/logout_usecase.dart';

class HomeController extends GetxController {

  final LogoutUseCase _logoutUseCase;
  HomeController(this._logoutUseCase);


  @override
  void onInit() async{
    super.onInit();
    var result = await SecureTokenStorage.read();

  }


  void logout() {
    _logoutUseCase();
  }
}
