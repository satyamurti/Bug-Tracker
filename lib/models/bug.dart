import 'package:bug_tracker/models/bug_priority.dart';
import 'package:bug_tracker/models/bug_status.dart';
import 'package:bug_tracker/models/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bug.g.dart';

@JsonSerializable()
class Bug {
  final String id;
  final String name;
  final String description;
  final String authorId, productId, orgId;
  final Role visibleTo;
  final BugStatus status;
  final BugPriority priority;
  final List<Discussion> discussion;
  final List<String> assignees, maintainers;
  final DateTime created;
  final DateTime due;

  factory Bug.fromJson(Map<String, dynamic> json) => _$BugFromJson(json);

  Bug(this.id, this.name, this.description, this.authorId, this.productId, this.orgId, this.visibleTo, this.status, this.priority, this.discussion, this.assignees, this.maintainers, this.created, this.due);

  Map<String, dynamic> toJson() => _$BugToJson(this);
}

@JsonSerializable()
class Discussion {
  final String userId;
  final String name;
  final String message;
  final DateTime time;

  factory Discussion.fromJson(Map<String, dynamic> json) => _$DiscussionFromJson(json);

  Map<String, dynamic> toJson() => _$DiscussionToJson(this);

  Discussion(this.userId, this.name, this.message, this.time);
}
