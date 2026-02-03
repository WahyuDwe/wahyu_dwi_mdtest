import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/domain/repositories/home/home_repository.dart';

import '../../../data/repositories/home/home_repository_impl.dart';
import '../../entities/user_entity.dart';

part 'get_users_usecase.g.dart';

@riverpod
GetUsersUseCase getUsersUseCase(Ref ref) {
  return GetUsersUseCase(ref.read(homeRepositoryProvider));
}

class GetUsersUseCase {
  final HomeRepository _repository;

  GetUsersUseCase(this._repository);

  Stream<List<UserEntity>> call() {
    return _repository.getUsers();
  }
}
