class UserInfo {
  final String id;
  final String userName;
  final String email;
  final String orgId;
  final List<String> teams;
  final int bugsResovled, bugsPending, bugsOverdue;
  final bool isLead;

  UserInfo(
    this.id,
    this.userName,
    this.email,
    this.orgId,
    this.teams,
    this.bugsResovled,
    this.bugsPending,
    this.bugsOverdue,
    this.isLead,
  );
  User.fromSnapshot(Map<String, dynamic> snapshot)
      : id = snapshot['id'],
        userName = snapshot['userName'],
        email = snapshot['email'],
        orgId = snapshot['orgId'],
        // cast List<dynamic> to List<String>
        teams = List<String>.from(snapshot['teams']),
        isLead = snapshot['isLead'],
        bugsResovled = snapshot['bugsResovled'],
        bugsPending = snapshot['bugsPending'],
        bugsOverdue = snapshot['bugsOverdue'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'email': email,
        'orgId': orgId,
        'teams': teams,
        'bugsResovled': bugsResovled,
        'bugsPending': bugsPending,
        'bugsOverdue': bugsOverdue,
        'isLead': isLead,
      };
}
