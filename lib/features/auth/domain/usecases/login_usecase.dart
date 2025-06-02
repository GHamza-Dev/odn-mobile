import '../entities/user.dart';
import '../repositories/auth_repo.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);
  Future<User> call(String u, String p) => repo.login(username: u, password: p);
}
