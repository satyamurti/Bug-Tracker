class Team {
  final String id;
  final String orgId;
  final String name, desc;
  final List<String> maintainers, devs;

  Team(
    this.id,
    this.orgId,
    this.name,
    this.desc,
    this.maintainers,
    this.devs,
  );
}
