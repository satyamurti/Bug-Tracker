import 'package:bug_tracker/models/auth/user.dart';

class Product {
  String id;
  String orgId;
  String name, desc;
  List<User> maintainers, developers;

  Product(
    this.id,
    this.orgId,
    this.name,
    this.desc,
    this.maintainers,
    this.developers,
  );
  Product.fromSnapshot(Map<String, dynamic> snapshot)
      : id = snapshot['id'],
        orgId = snapshot['orgId'],
        name = snapshot['name'],
        desc = snapshot['desc'],
        maintainers = List<User>.from(snapshot['maintainers']),
        developers = List<User>.from(snapshot['developers']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'orgId': orgId,
        'name': name,
        'desc': desc,
        'maintainers': maintainers,
        'developers': developers,
      };
}
