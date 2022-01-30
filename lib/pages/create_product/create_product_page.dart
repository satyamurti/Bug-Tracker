import 'package:bug_tracker/models/auth/product.dart';
import 'package:bug_tracker/models/auth/user_info.dart';
import 'package:bug_tracker/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a dummy product using product model
var product = Product('id', 'name', 'desc', 'orgId', null, null);

// ignore: must_be_immutable
class CreateProductPage extends ConsumerStatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateProductPage> createState() => _CreateProductPage();
}

class _CreateProductPage extends ConsumerState<CreateProductPage> {
  TextEditingController name = TextEditingController(),
      description = TextEditingController();
  @override
  build(BuildContext context) => Scaffold(
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
                    onChanged: (value) {
                      product.name = value;
                    },
                  ),
                  TextField(
                    controller: description,
                    decoration: const InputDecoration(labelText: 'Description'),
                    onChanged: (value) {
                      product.desc = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.black),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return DeveloperWidget(
                            users: users,
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 2),
                      child: Text('Select Developers',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: Colors.white)),
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

class DeveloperWidget extends StatefulWidget {
  List<UserInfo> users = [];
  DeveloperWidget({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  _DeveloperWidgetState createState() => _DeveloperWidgetState();
}

class _DeveloperWidgetState extends State<DeveloperWidget> {
  List<UserInfo> users = [];
  bool isChecked = false;
  List<UserInfo> devlopers = [];

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
              var user = widget.users[index];
              return ListTile(
                leading: const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/736x/7a/4b/4e/7a4b4eec27c898143aff26890e4f127a.jpg'),
                ),
                title: Text(
                  user.userName,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: GestureDetector(
                  onTap: () {
                    print(devlopers);
                    if (devlopers.contains(user)) {
                      devlopers.remove(user);
                      setState(() {
                        isChecked = false;
                      });
                      isChecked = false;
                    } else {
                      devlopers.add(user);
                      setState(() {
                        print('hello thambi');
                        isChecked = false;
                      });
                    }
                    product.developers = devlopers;
                  },
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                        side: BorderSide(
                            color:
                                isChecked ? Colors.transparent : Colors.grey)),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor:
                          isChecked ? Colors.green : Colors.transparent,
                      child: Icon(
                        Icons.check,
                        color: isChecked ? Colors.white : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ),
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
              if (product.developers!.isNotEmpty) {
                Navigator.pop(context);
              } else {
                print(product);
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
}
