class UserInfo {
  final String id;
  final String userName;
  final String email;
  final String orgId;
  final List<String> teams;
  final int bugsResovled, bugsPending, bugsOverdue;

  UserInfo(
    this.id,
    this.userName,
    this.email,
    this.orgId,
    this.teams,
    this.bugsResovled,
    this.bugsPending,
    this.bugsOverdue,
  );
}
