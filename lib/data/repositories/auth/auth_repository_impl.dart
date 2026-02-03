import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/data/sources/auth/auth_remote_source.dart';

import '../../../domain/repositories/auth/auth_repository.dart';

part 'auth_repository_impl.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.read(authRemoteSourceProvider));
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource _remoteSource;

  AuthRepositoryImpl(this._remoteSource);

  @override
  Future<Either<String, void>> forgotPassword(String email) async {
    try {
      await _remoteSource.forgotPassword(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  User? getCurrentUser() {
    return _remoteSource.getCurrentUser();
  }

  @override
  Future<Either<String, UserCredential>> signIn(
    String email,
    String password,
  ) async {
    try {
      final result = await _remoteSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await _remoteSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      await _remoteSource.signUp(email: email, password: password, name: name);

      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthError(e));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> syncEmailVerificationStatus() async {
    try {
      await _remoteSource.syncEmailVerificationStatus();
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Email tidak ditemukan. Silakan daftar dulu.';
      case 'wrong-password':
        return 'Password salah. Coba lagi.';
      case 'email-already-in-use':
        return 'Email sudah terdaftar. Gunakan email lain.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      case 'weak-password':
        return 'Password terlalu lemah.';
      default:
        return e.message ?? 'Terjadi kesalahan pada server.';
    }
  }
}
