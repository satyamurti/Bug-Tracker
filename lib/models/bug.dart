import 'package:bug_tracker/models/bug_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bug {
  var id;
  final String name;
  final String description;
  final String productId, orgId;
  final String status;
  final List<Discussion> discussion;
  final List<Role> assignees, maintainers;
  final DateTime created;
  final DateTime due;

  Bug(
      this.id,
      this.name,
      this.description,
      this.productId,
      this.orgId,
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
        status = parsedJSON['status'],
        discussion = List<Discussion>.from(
            parsedJSON['discussion'].map((x) => Discussion.fromJson(x))),
        maintainers = List<Role>.from(
            parsedJSON['maintainer'].map((x) => Role.fromJson(x))),
        assignees = List<Role>.from(
            parsedJSON['assignees'].map((x) => Role.fromJson(x))),
        due = (parsedJSON['due'] as Timestamp).toDate(),
        created = (parsedJSON['created'] as Timestamp).toDate();

  // Map<String, dynamic> toJson() => _$BugToJson(this);
}

class Role {
  final String userId;
  final String name;

  Role(this.userId, this.name);
  Role.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        userId = parsedJSON['id'];
}

class Discussion {
  final String userId;
  final String name;
  final String message;
  final DateTime time;

  // factory Discussion.fromJson(Map<String, dynamic> json) =>
  //     _$DiscussionFromJson(json);

  Map<String, dynamic> toJson() => _$DiscussionToJson(this);

  Discussion(this.userId, this.name, this.message, this.time);
  Discussion.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        message = parsedJSON['message'],
        time = (parsedJSON['time'] as Timestamp).toDate(),
        userId = parsedJSON['id'];
}
