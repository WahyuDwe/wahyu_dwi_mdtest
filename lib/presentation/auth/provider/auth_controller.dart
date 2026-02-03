import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/domain/usecase/auth/current_user_usecase.dart';

import '../../../domain/usecase/auth/forgot_password_usecase.dart';
import '../../../domain/usecase/auth/sign_in_usecase.dart';
import '../../../domain/usecase/auth/sign_out_usecase.dart';
import '../../../domain/usecase/auth/sign_up_usecase.dart';
import '../../../domain/usecase/auth/sync_email_verification_usecase.dart';

part 'auth_controller.g.dart';

/// Returns the current authenticated user from Firebase
@riverpod
User? currentUser(Ref ref) {
  return ref.read(currentUserUseCaseProvider).call();
}

/// Controller for authentication actions
/// Manages sign in, sign up, sign out, and password recovery
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  /// Signs in user with email and password
  /// Syncs email verification status after successful login
  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(signInUseCaseProvider);
    final result = await useCase.call(email, password);

    if (!ref.mounted) return;

    result.fold(
      (l) {
        state = AsyncValue.error(l, StackTrace.current);
      },
      (r) async {
        await ref.read(syncEmailVerificationUseCaseProvider).call();
        if (!ref.mounted) return;
        state = const AsyncValue.data(null);
      },
    );
  }

  /// Registers new user with name, email and password
  /// Sends verification email and syncs status to Firestore
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final useCase = ref.read(signUpUsecaseProvider);
    final result = await useCase(name: name, email: email, password: password);

    if (!ref.mounted) return;

    result.fold((l) => state = AsyncValue.error(l, StackTrace.current), (
      r,
    ) async {
      await ref.read(syncEmailVerificationUseCaseProvider).call();
      if (!ref.mounted) return;
      state = const AsyncValue.data(null);
    });
  }

  /// Signs out the current user
  Future<void> signOut() async {
    state = const AsyncValue.loading();

    final result = await ref.read(signOutUseCaseProvider).call();

    if (!ref.mounted) return;

    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = const AsyncValue.data(null),
    );
  }

  /// Sends password reset email to the provided email address
  Future<void> forgotPassword(String email) async {
    state = const AsyncValue.loading();

    final result = await ref.read(forgotPasswordUseCaseProvider).call(email);

    if (!ref.mounted) return;

    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = const AsyncValue.data(null),
    );
  }
}
