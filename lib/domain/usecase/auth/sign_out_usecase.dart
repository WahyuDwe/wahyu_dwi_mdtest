import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth/auth_repository_impl.dart';
import '../../repositories/auth/auth_repository.dart';

part 'sign_out_usecase.g.dart';

@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return SignOutUseCase(ref.read(authRepositoryProvider));
}

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<Either<String, void>> call() {
    return _repository.signOut();
  }
}
