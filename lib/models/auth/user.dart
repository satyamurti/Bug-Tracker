class User {
  final String id;
  final String userName;
  final String name, email;
  final String orgId;
  final List<String> teams;
  final int bugsResovled, bugsPending, bugsOverdue;

  User(
    this.id,
    this.userName,
    this.name,
    this.email,
    this.orgId,
    this.teams,
    this.bugsResovled,
    this.bugsPending,
    this.bugsOverdue,
  );
}
