import '../../entities/user_entity.dart';

abstract class HomeRepository {
  Stream<List<UserEntity>> getUsers();
}
