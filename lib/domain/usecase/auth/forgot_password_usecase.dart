import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth/auth_repository_impl.dart';
import '../../repositories/auth/auth_repository.dart';

part 'forgot_password_usecase.g.dart';

@riverpod
ForgotPasswordUseCase forgotPasswordUseCase(Ref ref) {
  return ForgotPasswordUseCase(ref.read(authRepositoryProvider));
}

class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<Either<String, void>> call(String email) {
    return _repository.forgotPassword(email);
  }
}
