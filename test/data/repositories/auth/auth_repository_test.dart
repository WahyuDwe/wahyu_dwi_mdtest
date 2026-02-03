import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wahyu_dwi_mdtest/data/repositories/auth/auth_repository_impl.dart';
import 'package:wahyu_dwi_mdtest/data/sources/auth/auth_remote_source.dart';

import 'auth_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRemoteSource>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteSource mockRemoteSource;
  late MockUserCredential mockUserCredential;

  setUp(() {
    mockRemoteSource = MockAuthRemoteSource();
    repository = AuthRepositoryImpl(mockRemoteSource);
    mockUserCredential = MockUserCredential();
  });

  group('AuthRepository Tests', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    const tName = 'Test User';

    // --- TEST 1: LOGIN (Authentication) ---
    test(
      'Sign In should return UserCredential when remote source succeeds',
      () async {
        // Arrange
        when(
          mockRemoteSource.signIn(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => mockUserCredential);

        // Act
        final result = await repository.signIn(tEmail, tPassword);

        // Assert
        expect(result, equals(Right(mockUserCredential)));

        // Verify
        verify(
          mockRemoteSource.signIn(email: tEmail, password: tPassword),
        ).called(1);
      },
    );

    test(
      'Sign In should return Left (Error) when remote source fails',
      () async {
        // Arrange
        when(
          mockRemoteSource.signIn(email: tEmail, password: tPassword),
        ).thenThrow(
          FirebaseAuthException(
            code: 'user-not-found',
            message: 'User not found',
          ),
        );
        // Act
        final result = await repository.signIn(tEmail, tPassword);

        // Assert
        expect(result.isLeft(), true);
      },
    );

    // --- TEST 2: REGISTER & EMAIL VERIFICATION ---
    test('Sign Up should complete successfully', () async {
      // Arrange
      when(
        mockRemoteSource.signUp(
          name: tName,
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => {});

      // Act
      final result = await repository.signUp(tName, tEmail, tPassword);

      // Assert
      expect(result.isRight(), true);
      verify(
        mockRemoteSource.signUp(
          name: tName,
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
    });

    // --- TEST 3: PASSWORD RESET ---
    test('Forgot Password should call remote source successfully', () async {
      // Arrange
      when(
        mockRemoteSource.forgotPassword(email: tEmail),
      ).thenAnswer((_) async => {});

      // Act
      final result = await repository.forgotPassword(tEmail);

      // Assert
      expect(result.isRight(), true);
      verify(mockRemoteSource.forgotPassword(email: tEmail)).called(1);
    });
  });
}
