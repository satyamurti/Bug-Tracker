import 'package:bug_tracker/models/auth/user_info.dart';

class Product {
  String id;
  String orgId;
  String name, desc;
  List<UserInfo> maintainers, developers;

  Product(
    this.id,
    this.orgId,
    this.name,
    this.desc,
    this.maintainers,
    this.developers,
  );
  Product.fromJson(Map<String, dynamic> snapshot)
      : id = snapshot['id'],
        orgId = snapshot['orgId'],
        name = snapshot['name'],
        desc = snapshot['desc'],
        maintainers = List<UserInfo>.from(snapshot['maintainers']),
        developers = List<UserInfo>.from(snapshot['developers']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'orgId': orgId,
        'name': name,
        'desc': desc,
        'maintainers': maintainers,
        'developers': developers,
      };
}
