import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<String, UserCredential>> signIn(String email, String password);

  Future<Either<String, void>> signUp(
    String name,
    String email,
    String password,
  );

  Future<Either<String, void>> signOut();

  Future<Either<String, void>> forgotPassword(String email);

  User? getCurrentUser();

  Future<Either<String, void>> syncEmailVerificationStatus();
}
