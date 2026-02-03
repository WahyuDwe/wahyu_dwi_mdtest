import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/data/models/auth/user_model.dart';

import '../../../core/providers/firebase_providers.dart';

part 'auth_remote_source.g.dart';

@Riverpod(keepAlive: true)
AuthRemoteSource authRemoteSource(Ref ref) {
  return AuthRemoteSourceImpl(
    ref.watch(firebaseAuthProvider),
    ref.watch(firebaseFirestoreProvider),
  );
}

abstract class AuthRemoteSource {
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<void> forgotPassword({required String email});

  Future<void> signOut();

  User? getCurrentUser();

  Future<void> syncEmailVerificationStatus();
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteSourceImpl(this._auth, this._firestore);

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();

      try {
        await user.sendEmailVerification();
      } catch (e) {
        print("Gagal kirim email verifikasi: $e");
      }

      final newUser = UserModel(
        uid: user.uid,
        email: email,
        name: name,
        isVerified: false,
        createdAt: DateTime.now().toIso8601String(),
      );
      await _firestore.collection('users').doc(user.uid).set(newUser.toJson());
    }
  }

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Sync email verification status from Firebase Auth to Firestore
  @override
  Future<void> syncEmailVerificationStatus() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      final updatedUser = _auth.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        // Update Firestore isVerified field
        await _firestore.collection('users').doc(updatedUser.uid).update({
          'isVerified': true,
        });
      }
    }
  }
}
