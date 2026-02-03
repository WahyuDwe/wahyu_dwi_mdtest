import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wahyu_dwi_mdtest/domain/entities/user_entity.dart';
import 'package:wahyu_dwi_mdtest/domain/usecase/home/get_users_usecase.dart';
import 'package:wahyu_dwi_mdtest/presentation/home/provider/home_controller.dart';

import 'home_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetUsersUseCase>()])
void main() {
  late MockGetUsersUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetUsersUseCase();
  });

  group('HomeController Logic Tests', () {
    // Dummy Data
    final tUserList = [
      const UserEntity(
        uid: '1',
        name: 'Wahyu',
        email: 'wahyu@test.com',
        isVerified: true,
      ),
      const UserEntity(
        uid: '2',
        name: 'Dwi',
        email: 'dwi@test.com',
        isVerified: false,
      ),
      const UserEntity(
        uid: '3',
        name: 'Agus',
        email: 'agus@other.com',
        isVerified: true,
      ),
    ];

    // --- TEST 1: USER LIST FILTERING & SEARCHING ---
    test(
      'Should return all users when no filter or search is applied',
      () async {
        // Arrange
        when(mockUseCase.call()).thenAnswer((_) => Stream.value(tUserList));

        final container = ProviderContainer(
          overrides: [getUsersUseCaseProvider.overrideWithValue(mockUseCase)],
        );

        // Act - Listen to the stream
        final listener = container.listen<AsyncValue<List<UserEntity>>>(
          userListProvider,
          (_, _) {},
        );

        // Wait for the stream to emit
        await container.read(userListProvider.future);

        // Assert
        expect(listener.read().value, tUserList);

        container.dispose();
      },
    );

    // --- TEST 2: FILTER BY VERIFIED STATUS ---
    test('Should filter users by verified status correctly', () async {
      // Arrange
      when(mockUseCase.call()).thenAnswer((_) => Stream.value(tUserList));

      final container = ProviderContainer(
        overrides: [getUsersUseCaseProvider.overrideWithValue(mockUseCase)],
      );

      // Act
      container
          .read(filterStatusProvider.notifier)
          .setFilter(UserFilter.verified);

      final listener = container.listen<AsyncValue<List<UserEntity>>>(
        userListProvider,
        (_, _) {},
      );

      await container.read(userListProvider.future);

      // Assert
      final result = listener.read().value!;
      expect(result.length, 2); // Wahyu & Agus
      expect(result.every((u) => u.isVerified), true);

      container.dispose();
    });

    // --- TEST 3: FILTER BY UNVERIFIED STATUS ---
    test('Should filter users by unverified status correctly', () async {
      // Arrange
      when(mockUseCase.call()).thenAnswer((_) => Stream.value(tUserList));

      final container = ProviderContainer(
        overrides: [getUsersUseCaseProvider.overrideWithValue(mockUseCase)],
      );

      // Act
      container
          .read(filterStatusProvider.notifier)
          .setFilter(UserFilter.unverified);

      final listener = container.listen<AsyncValue<List<UserEntity>>>(
        userListProvider,
        (_, _) {},
      );

      await container.read(userListProvider.future);

      // Assert
      final result = listener.read().value!;
      expect(result.length, 1); // Only Dwi
      expect(result.first.name, 'Dwi');

      container.dispose();
    });

    // --- TEST 4: SEARCH FUNCTIONALITY ---
    test('Should filter users by search query (name)', () async {
      // Arrange
      when(mockUseCase.call()).thenAnswer((_) => Stream.value(tUserList));

      final container = ProviderContainer(
        overrides: [getUsersUseCaseProvider.overrideWithValue(mockUseCase)],
      );

      // Act
      container.read(searchQueryProvider.notifier).setQuery('Agus');

      final listener = container.listen<AsyncValue<List<UserEntity>>>(
        userListProvider,
        (_, _) {},
      );

      await container.read(userListProvider.future);

      // Assert
      final result = listener.read().value!;
      expect(result.length, 1);
      expect(result.first.name, 'Agus');

      container.dispose();
    });

    // --- TEST 5: SEARCH BY EMAIL ---
    test('Should filter users by search query (email)', () async {
      // Arrange
      when(mockUseCase.call()).thenAnswer((_) => Stream.value(tUserList));

      final container = ProviderContainer(
        overrides: [getUsersUseCaseProvider.overrideWithValue(mockUseCase)],
      );

      // Act
      container.read(searchQueryProvider.notifier).setQuery('dwi@test.com');

      final listener = container.listen<AsyncValue<List<UserEntity>>>(
        userListProvider,
        (_, _) {},
      );

      await container.read(userListProvider.future);

      // Assert
      final result = listener.read().value!;
      expect(result.length, 1);
      expect(result.first.email, 'dwi@test.com');

      container.dispose();
    });

    // --- TEST 6: SEARCH WITH NO MATCHES ---
    test('Should return empty list when search yields no results', () async {
      // Arrange
      when(mockUseCase.call()).thenAnswer((_) => Stream.value(tUserList));

      final container = ProviderContainer(
        overrides: [getUsersUseCaseProvider.overrideWithValue(mockUseCase)],
      );

      // Act
      container.read(searchQueryProvider.notifier).setQuery('NonExistentUser');

      final listener = container.listen<AsyncValue<List<UserEntity>>>(
        userListProvider,
        (_, _) {},
      );

      await container.read(userListProvider.future);

      // Assert
      final result = listener.read().value!;
      expect(result, isEmpty);

      container.dispose();
    });
  });
}
