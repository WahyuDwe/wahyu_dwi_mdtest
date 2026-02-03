import 'package:flutter/material.dart';

import '../../../domain/entities/user_entity.dart';

class UserListItem extends StatelessWidget {
  final UserEntity user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: _buildAvatar(colorScheme),
        title: Text(
          user.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            user.email,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        trailing: _buildStatusIcon(colorScheme),
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    return CircleAvatar(
      backgroundColor: user.isVerified
          ? colorScheme.primaryContainer
          : colorScheme.errorContainer,
      child: Text(
        user.name.isNotEmpty ? user.name[0].toUpperCase() : "?",
        style: TextStyle(
          color: user.isVerified ? colorScheme.primary : colorScheme.error,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusIcon(ColorScheme colorScheme) {
    return Icon(
      user.isVerified ? Icons.verified : Icons.error_outline,
      color: user.isVerified ? colorScheme.primary : colorScheme.error,
      size: 24,
    );
  }
}
