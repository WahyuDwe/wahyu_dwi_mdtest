import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/domain/usecase/auth/current_user_usecase.dart';

import '../../../domain/usecase/auth/forgot_password_usecase.dart';
import '../../../domain/usecase/auth/sign_in_usecase.dart';
import '../../../domain/usecase/auth/sign_out_usecase.dart';
import '../../../domain/usecase/auth/sign_up_usecase.dart';

part 'auth_controller.g.dart';

@riverpod
User? currentUser(Ref ref) {
  return ref.read(currentUserUseCaseProvider).call();
}

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(signInUseCaseProvider);
    final result = await useCase.call(email, password);

    result.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) {
        state = const AsyncValue.data(null);
      },
    );
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(signUpUsecaseProvider);
    final result = await useCase(name: name, email: email, password: password);

    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = const AsyncValue.data(null),
    );
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    final result = await ref.read(signOutUseCaseProvider).call();

    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = const AsyncValue.data(null),
    );
  }

  Future<void> forgotPassword(String email) async {
    state = const AsyncValue.loading();

    final result = await ref.read(forgotPasswordUseCaseProvider).call(email);

    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = const AsyncValue.data(null),
    );
  }
}
