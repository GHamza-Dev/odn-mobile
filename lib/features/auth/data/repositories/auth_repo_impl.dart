import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasources/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<User> login({required String username, required String password}) async {
    final dto = await remote.login(username, password);
    return dto.toEntity();
  }
}
