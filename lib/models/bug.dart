import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bug_tracker/models/bug_priority.dart';
import 'package:bug_tracker/models/bug_status.dart';
import 'package:bug_tracker/models/role.dart';

class Bug {
  var id;
  final String name;
  final String description;
  final String productId;
  final String orgId;
  final String isVisible;
  final String status;
  final List<Discussion> discussion;
  final List<String> assignees, maintainers;
  final DateTime created;
  final DateTime due;

  // factory Bug.fromJson(Map<String, dynamic> json) => _$BugFromJson(json);

  // Map<String, dynamic> toJson() => _$BugToJson(this);

  Bug(
      this.id,
      this.name,
      this.description,
      this.productId,
      this.orgId,
      this.isVisible,
      this.status,
      this.maintainers,
      this.assignees,
      this.discussion,
      this.due,
      this.created);

  Bug.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        description = parsedJSON['description'],
        productId = parsedJSON['productId'],
        orgId = parsedJSON['orgId'],
        isVisible = parsedJSON['visibility'],
        status = parsedJSON['status'],
        discussion = List<Discussion>.from(
            parsedJSON['discussion'].map((x) => Discussion.fromJson(x))),
        maintainers = List<String>.from(parsedJSON['maintainer'].map((x) => x)),
        assignees = List<String>.from(parsedJSON['assignees'].map((x) => x)),
        due = (parsedJSON['due'] as Timestamp).toDate(),
        created = (parsedJSON['created'] as Timestamp).toDate();

  // bugPriority = parsedJSON['bugPriority'];
  //this.assignees,

}

class Discussion {
  final String userId;
  final String name;
  final String message;
  final DateTime time;

  Discussion(this.userId, this.name, this.message, this.time);

  Discussion.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        userId = parsedJSON['userId'],
        message = parsedJSON['message'],
        time = (parsedJSON['time'] as Timestamp).toDate();
}
