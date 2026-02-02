import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth/auth_repository_impl.dart';
import '../../repositories/auth/auth_repository.dart';

part 'current_user_usecase.g.dart';

@riverpod
CurrentUserUseCase currentUserUseCase(Ref ref) {
  return CurrentUserUseCase(ref.read(authRepositoryProvider));
}

class CurrentUserUseCase {
  final AuthRepository _repository;

  CurrentUserUseCase(this._repository);

  User? call() {
    return _repository.getCurrentUser();
  }
}
