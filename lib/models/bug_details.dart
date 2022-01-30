import 'package:bug_tracker/models/bug.dart';

class BugDetails {
  final List<Bug> bugs;
  final int raised;
  final int resolved;
  final int pending;

  BugDetails(this.bugs, this.raised, this.resolved, this.pending);
}
