import 'package:bug_tracker/models/auth/product.dart';
import 'package:bug_tracker/models/auth/user_info.dart';
import 'package:bug_tracker/models/bug_priority.dart';
import 'package:bug_tracker/models/role.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class NewBugPage extends StatelessWidget {
  final UserInfo userInfo;
  final Product product;

  const NewBugPage({Key? key, required this.userInfo, required this.product})
      : super(key: key);

  @override
  build(context) => Scaffold(
        appBar: AppBar(
          // TODO: show product name instead of id
          title: Text('New Bug in ${product.name}'),
        ),
        body: content(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Create New Bug'),
            ),
          ),
        ),
      );

  content() => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Title')),
            const TextField(
                decoration: InputDecoration(labelText: 'Description')),
            const SizedBox(height: 20),
            DropdownSearch(
              mode: Mode.MENU,
              items: roleList,
              selectedItem: roleList[0],
              dropdownSearchDecoration:
                  const InputDecoration(label: Text('Visible until')),
            ),
            const SizedBox(height: 20),
            DropdownSearch(
              mode: Mode.MENU,
              items: priorityList,
              selectedItem: priorityList[0],
              dropdownSearchDecoration:
                  const InputDecoration(label: Text('Priority')),
            ),
            const SizedBox(height: 20),
            // TODO: add check for min 1 maintainer
            DropdownSearch.multiSelection(
              mode: Mode.MENU,
              items: product.maintainers + product.devs,
              selectedItems: const [],
              dropdownSearchDecoration:
                  const InputDecoration(label: Text('Assigned To')),
            ),
            // TODO: deadline selection
          ],
        ),
      );
}
