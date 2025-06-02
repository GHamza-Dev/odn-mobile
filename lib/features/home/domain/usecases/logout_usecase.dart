
import 'package:switch_config/features/home/domain/repositories/home_repository.dart';

class LogoutUseCase {
  final HomeRepository _repo;
  LogoutUseCase(this._repo);

  Future<void> call() => _repo.logout();
}
