import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/domain/repositories/home/home_repository.dart';

import '../../../domain/entities/user_entity.dart';
import '../../mapper/user_mapper.dart';
import '../../sources/home/home_remote_source.dart';

part 'home_repository_impl.g.dart';

@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) {
  return HomeRepositoryImpl(ref.read(homeRemoteSourceProvider));
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteSource _remoteSource;
  HomeRepositoryImpl(this._remoteSource);

  @override
  Stream<List<UserEntity>> getUsers() {
    final streamModels = _remoteSource.getUsers();

    return streamModels.map((listModels) {
      return listModels.toEntityList();
    });
  }
}
