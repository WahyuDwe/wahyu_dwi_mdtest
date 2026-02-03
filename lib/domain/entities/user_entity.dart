class UserEntity {
  final String uid;
  final String name;
  final String email;
  final bool isVerified;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.isVerified,
  });
}
