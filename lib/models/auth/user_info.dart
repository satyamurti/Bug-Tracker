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

  UserInfo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        userName = map['userName'],
        email = map['email'],
        orgId = map['orgId'],
        teams = (map['teams'] == null)
            ? []
            : (map['teams'] as List<dynamic>).map((e) => e as String).toList(),
        bugsResovled = map['bugsResovled'] ?? 0,
        bugsPending = map['bugsPending'] ?? 0,
        bugsOverdue = map['bugsOverdue'] ?? 0;
}
