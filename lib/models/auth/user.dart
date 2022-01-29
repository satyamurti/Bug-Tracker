class User {
  final String id;
  final String userName;
  final String name, email;
  final String orgId;
  final List<String> teams;

  User(
    this.id,
    this.userName,
    this.name,
    this.email,
    this.orgId,
    this.teams,
  );
}
