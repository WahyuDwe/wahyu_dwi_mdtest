import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wahyu_dwi_mdtest/domain/usecase/home/get_users_usecase.dart';

import '../../../core/providers/firebase_providers.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecase/auth/sync_email_verification_usecase.dart';
import '../../auth/provider/auth_controller.dart';

part 'home_controller.g.dart';

/// Filter options for user list
enum UserFilter { all, verified, unverified }

/// Manages search query state for filtering users
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

/// Manages active filter status
@riverpod
class FilterStatus extends _$FilterStatus {
  @override
  UserFilter build() => UserFilter.all;

  void setFilter(UserFilter filter) => state = filter;
}

/// Controller for home screen actions
@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
  @override
  void build() {}

  /// Refreshes current user status from Firebase server
  /// and invalidates auth provider to trigger UI rebuild
  Future<void> refreshUserStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();

      // Sync verification status from Firebase Auth to Firestore
      await ref.read(syncEmailVerificationUseCaseProvider).call();

      // Invalidate providers untuk trigger UI refresh
      ref.invalidate(firebaseAuthProvider);
      ref.invalidate(currentUserProvider);
      ref.invalidate(userListProvider);
    }
  }
}

/// Provides filtered and searched list of users as a stream
/// Applies client-side filtering based on search query and filter status
@riverpod
Stream<List<UserEntity>> userList(Ref ref) {
  final usersStream = ref.watch(getUsersUseCaseProvider).call();
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  final filter = ref.watch(filterStatusProvider);

  return usersStream.map((users) {
    return users.where((user) {
      bool matchesFilter =
          filter == UserFilter.all ||
          (filter == UserFilter.verified && user.isVerified) ||
          (filter == UserFilter.unverified && !user.isVerified);

      bool matchesSearch =
          user.name.toLowerCase().contains(searchQuery) ||
          user.email.toLowerCase().contains(searchQuery);

      return matchesFilter && matchesSearch;
    }).toList();
  });
}
