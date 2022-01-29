import 'package:bug_tracker/models/bug_priority.dart';
import 'package:bug_tracker/models/bug_status.dart';

class Bug {
  final int id;
  final String author;
  final String teamId;
  final bool isVisible;
  final BugStatus status;
  final BugPriority bugPriority;
  final int duplicateOf;
  final List<String> assignees;
  final String deadline;

  Bug(this.id, this.author, this.teamId, this.isVisible, this.status,
      this.bugPriority, this.duplicateOf, this.assignees, this.deadline);
}
