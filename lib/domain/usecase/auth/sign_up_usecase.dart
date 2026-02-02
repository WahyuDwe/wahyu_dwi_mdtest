import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/domain/repositories/auth/auth_repository.dart';

import '../../../data/repositories/auth/auth_repository_impl.dart';

part 'sign_up_usecase.g.dart';

@riverpod
SignUpUsecase signUpUsecase(Ref ref) {
  return SignUpUsecase(ref.read(authRepositoryProvider));
}

class SignUpUsecase {
  final AuthRepository _repository;

  SignUpUsecase(this._repository);

  Future<Either<String, void>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repository.signUp(name, email, password);
  }
}
