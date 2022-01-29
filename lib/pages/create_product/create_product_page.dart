import 'package:bug_tracker/models/auth/team.dart';
import 'package:bug_tracker/models/auth/user.dart';
import 'package:bug_tracker/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Product? product;

// ignore: must_be_immutable
class CreateProductPage extends ConsumerWidget {
  TextEditingController name = TextEditingController(),
      description = TextEditingController();

  CreateProductPage({Key? key}) : super(key: key);

  @override
  build(BuildContext context, WidgetRef ref) => Scaffold(
      appBar: AppBar(title: const Text('Create a new product')),
      body: ref.watch(firebaseIdeaProvider).when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text(err.toString())),
          data: (users) {
            print(users.length);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: description,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return TaskAssigneeWidget(
                            users: users,
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Select Developers',
                    ),
                  ),
                  const Text(
                    'Select Managers',
                  ),
                ],
              ),
            );
          }));
}

class TaskAssigneeWidget extends StatefulWidget {
  List<User> users = [];
  TaskAssigneeWidget({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  _TaskAssigneeWidgetState createState() => _TaskAssigneeWidgetState();
}

class _TaskAssigneeWidgetState extends State<TaskAssigneeWidget> {
  List<User> users = [];
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          Container(
            height: 8,
            width: 50,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(45)),
          ),
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            children: List.generate(widget.users.length, (index) {
              return AssigneeTileWidget(
                isChecked: _isChecked(widget.users[index]),
                selectedUser: widget.users[index],
                onTap: (User user) {
                  setState(() {
                    isChecked = true;
                  });
                  product!.developers = users;
                },
              );
            }),
          ),
          const SizedBox(
            height: 25,
          ),
          TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.black),
            onPressed: () {
              setState(() {
                product!.developers = users;
              });
              if (product!.developers.isNotEmpty) {
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('Done',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _isChecked(User user) {
    if (product != null) {
      if (product!.developers.contains(user)) {
        return true;
      }
    } else {
      return false;
    }
  }
}

class AssigneeTileWidget extends StatelessWidget {
  const AssigneeTileWidget(
      {Key? key,
      required this.onTap,
      required this.selectedUser,
      required this.isChecked})
      : super(key: key);
  final bool isChecked;
  final User selectedUser;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(selectedUser.userName),
      ),
      title: Text(
        selectedUser.userName,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: GestureDetector(
        onTap: () {
          onTap(selectedUser);
        },
        child: Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
              side: BorderSide(
                  color: isChecked ? Colors.transparent : Colors.grey)),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: isChecked ? Colors.green : Colors.transparent,
            child: Icon(
              Icons.check,
              color: isChecked ? Colors.white : Colors.grey,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}