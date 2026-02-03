import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth/auth_repository_impl.dart';
import '../../repositories/auth/auth_repository.dart';

part 'sync_email_verification_usecase.g.dart';

@riverpod
SyncEmailVerificationUseCase syncEmailVerificationUseCase(Ref ref) {
  return SyncEmailVerificationUseCase(ref.read(authRepositoryProvider));
}

class SyncEmailVerificationUseCase {
  final AuthRepository _repository;

  SyncEmailVerificationUseCase(this._repository);

  Future<Either<String, void>> call() async {
    return await _repository.syncEmailVerificationStatus();
  }
}
