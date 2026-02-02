import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth/auth_repository_impl.dart';
import '../../repositories/auth/auth_repository.dart';

part 'sign_in_usecase.g.dart';

@riverpod
SignInUseCase signInUseCase(Ref ref) {
  return SignInUseCase(ref.read(authRepositoryProvider));
}

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<String, UserCredential>> call(String email, String password) {
    return _repository.signIn(email, password);
  }
}
