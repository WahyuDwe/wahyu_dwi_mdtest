import '../models/auth/user_model.dart';
import '../../domain/entities/user_entity.dart';

// UserModel -> UserEntity
extension UserMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      name: name,
      email: email,
      isVerified: isVerified,
    );
  }
}

// List<UserModel> -> List<UserEntity>
extension UserListMapper on List<UserModel> {
  List<UserEntity> toEntityList() {
    return map((model) => model.toEntity()).toList();
  }
}
