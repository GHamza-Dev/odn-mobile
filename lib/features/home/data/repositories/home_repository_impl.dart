import 'package:switch_config/features/home/data/datasources/home_datasource.dart';
import 'package:switch_config/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;
  HomeRepositoryImpl(this.remote);

  @override
  Future<void> logout() => remote.logout();

}
