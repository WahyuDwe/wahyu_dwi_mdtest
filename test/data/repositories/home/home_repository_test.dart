import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wahyu_dwi_mdtest/data/models/auth/user_model.dart';
import 'package:wahyu_dwi_mdtest/data/repositories/home/home_repository_impl.dart';
import 'package:wahyu_dwi_mdtest/data/sources/home/home_remote_source.dart';
import 'package:wahyu_dwi_mdtest/domain/entities/user_entity.dart';

import 'home_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HomeRemoteSource>()])
void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteSource mockRemoteSource;

  setUp(() {
    mockRemoteSource = MockHomeRemoteSource();
    repository = HomeRepositoryImpl(mockRemoteSource);
  });

  group('HomeRepositoryImpl Tests', () {
    // Data Dummy
    final tUserModelList = [
      UserModel(
        uid: 'user1',
        name: 'Wahyu',
        email: 'wahyu@test.com',
        isVerified: true,
        createdAt: '2023-01-01',
      ),
      UserModel(
        uid: 'user2',
        name: 'Dwi',
        email: 'dwi@test.com',
        isVerified: false,
        createdAt: '2023-01-02',
      ),
    ];

    // --- TEST 1: GET USERS ---
    test(
      'getUsers should return Stream<List<UserEntity>> and data should be mapped correctly',
      () {
        // ARRANGE
        when(
          mockRemoteSource.getUsers(),
        ).thenAnswer((_) => Stream.value(tUserModelList));

        // ACT
        final resultStream = repository.getUsers();

        // ASSERT
        expect(
          resultStream,
          emits(
            predicate<List<UserEntity>>((entities) {
              if (entities.length != 2) return false;

              final user1 = entities[0];
              return user1.uid == 'user1' &&
                  user1.name == 'Wahyu' &&
                  user1.isVerified == true;
            }),
          ),
        );

        // VERIFY
        verify(mockRemoteSource.getUsers()).called(1);
      },
    );
  });
}
