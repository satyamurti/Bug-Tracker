import 'package:bug_tracker/components/date_picker_button.dart';
import 'package:bug_tracker/models/auth/product.dart';
import 'package:bug_tracker/models/auth/user_info.dart';
import 'package:bug_tracker/models/bug.dart';
import 'package:bug_tracker/models/bug_priority.dart';
import 'package:bug_tracker/models/bug_status.dart';
import 'package:bug_tracker/models/request.dart';
import 'package:bug_tracker/models/role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewBugNotifier extends StateNotifier<Request> {
  NewBugNotifier() : super(Request.initial);

  void createNewBug(Bug bug) async {
    state = Request.loading;
    try {
      await FirebaseFirestore.instance
          .collection('bugs')
          .doc(bug.id.toString())
          .set(bug.toJson());
      state = Request.succes;
    } catch (e) {
      state = Request.failure;
    }
  }
}

final newBugProvider =
    StateNotifierProvider<NewBugNotifier, Request>((ref) => NewBugNotifier());

class NewBugPage extends ConsumerStatefulWidget {
  final UserInfo userInfo;
  final Product product;

  const NewBugPage({Key? key, required this.userInfo, required this.product})
      : super(key: key);

  @override
  ConsumerState<NewBugPage> createState() => _NewBugPageState();
}

class _NewBugPageState extends ConsumerState<NewBugPage> {
  TextEditingController title = TextEditingController(),
      description = TextEditingController();
  Role visibleTo = Role.lead;
  BugPriority priority = BugPriority.minor;
  List<String> assignees = [];
  late DateTime deadline;

  @override
  build(context) => Scaffold(
        appBar: AppBar(
          // TODO: show product name instead of id
          title: Text('New Bug in ${widget.product.name}'),
        ),
        body: content(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: onCreateNewBugClick,
              child: const Text('Create New Bug'),
            ),
          ),
        ),
      );

  content() => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            // TODO: multiline
            TextField(
              controller: description,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 20),
            DropdownSearch<String>(
              mode: Mode.MENU,
              items: roleList,
              selectedItem: roleList[0],
              dropdownSearchDecoration:
                  const InputDecoration(label: Text('Visible until')),
              onChanged: (s) {
                if (s != null) {
                  visibleTo = roleFromString(s);
                }
              },
            ),
            const SizedBox(height: 20),
            DropdownSearch<String>(
              mode: Mode.MENU,
              items: priorityList,
              selectedItem: priorityList[0],
              dropdownSearchDecoration:
                  const InputDecoration(label: Text('Priority')),
              onChanged: (s) {
                if (s != null) {
                  priority = priorityFromString(s);
                }
              },
            ),
            const SizedBox(height: 20),
            // TODO: add check for min 1 maintainer
            DropdownSearch<String>.multiSelection(
              mode: Mode.MENU,
              items: widget.product.maintainers + widget.product.devs,
              selectedItems: const [],
              dropdownSearchDecoration:
                  const InputDecoration(label: Text('Assigned To')),
              onChanged: (v) => assignees = v,
            ),
            const SizedBox(height: 20),
            DatePickerButton(
              text: 'Select a Deadline',
              onDateSelected: (date) => deadline = date,
            ),
          ],
        ),
      );

  void onCreateNewBugClick() {
    final newBug = Bug(
      DateTime.now().millisecondsSinceEpoch.toString(),
      title.text,
      description.text,
      widget.userInfo.id,
      widget.product.id,
      visibleTo,
      BugStatus.raised,
      priority,
      assignees,
      deadline,
    );
    print(newBug.toJson());
    // Timestamp.fromDate(date)
    // final notifier = ref.read(newBugProvider.notifier);
    // notifier.createNewBug(newBug);
  }
}
