import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/provider/auth_controller.dart';
import 'provider/home_controller.dart';
import 'widget/empty_state.dart';
import 'widget/filter_chip_widget.dart';
import 'widget/user_header.dart';
import 'widget/user_list_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final userListAsync = ref.watch(userListProvider);
    final currentFilter = ref.watch(filterStatusProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(ref, theme),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(homeControllerProvider.notifier).refreshUserStatus();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (currentUser != null) UserHeader(user: currentUser),
              _buildSearchAndFilter(ref, currentFilter, theme),
              const SizedBox(height: 8),
              _buildUserList(userListAsync, currentUser, theme),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(WidgetRef ref, ThemeData theme) {
    return AppBar(
      title: Text(
        "Home",
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Sign Out',
          onPressed: () async {
            await ref.read(authControllerProvider.notifier).signOut();
          },
        ),
      ],
    );
  }

  Widget _buildSearchAndFilter(
    WidgetRef ref,
    UserFilter currentFilter,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Users",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSearchField(ref, theme),
          const SizedBox(height: 12),
          _buildFilterChips(ref, currentFilter),
        ],
      ),
    );
  }

  Widget _buildSearchField(WidgetRef ref, ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by name or email',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onChanged: (value) {
        ref.read(searchQueryProvider.notifier).setQuery(value);
      },
    );
  }

  Widget _buildFilterChips(WidgetRef ref, UserFilter currentFilter) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChipWidget(
            label: 'All',
            isSelected: currentFilter == UserFilter.all,
            onSelected: () => ref
                .read(filterStatusProvider.notifier)
                .setFilter(UserFilter.all),
          ),
          const SizedBox(width: 8),
          FilterChipWidget(
            label: 'Verified',
            isSelected: currentFilter == UserFilter.verified,
            onSelected: () => ref
                .read(filterStatusProvider.notifier)
                .setFilter(UserFilter.verified),
          ),
          const SizedBox(width: 8),
          FilterChipWidget(
            label: 'Unverified',
            isSelected: currentFilter == UserFilter.unverified,
            onSelected: () => ref
                .read(filterStatusProvider.notifier)
                .setFilter(UserFilter.unverified),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(
    AsyncValue userListAsync,
    currentUser,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: userListAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const EmptyState();
          }

          final filteredUsers = users
              .where((user) => user.uid != currentUser?.uid)
              .toList();

          if (filteredUsers.isEmpty) {
            return const EmptyState();
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredUsers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return UserListItem(user: filteredUsers[index]);
            },
          );
        },
        error: (err, stack) => Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Error: $err',
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ),
        loading: () => const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
