class Team {
  var id;
  // final String orgId;
  final String name, desc;
//  final List<String> maintainers, devs;

  Team(
    //   this.orgId,
    this.name,
    this.desc,
    //  this.maintainers,
    //this.devs,
  );

  Team.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        desc = parsedJSON['desc'];
}
