import 'package:bug_tracker/providers/bugs_provider.dart';
import 'package:bug_tracker/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBar extends ConsumerWidget {
  final PageController controller;
  const NavBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int indexNotifier = ref.watch(indexProvider) as int;
    return Container(
        decoration:
            BoxDecoration(color: Colors.pink.shade900.withOpacity(0.85)),
        child: Column(children: [
          const Flexible(
              child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('BUG TRACKER',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white)))),
          const Divider(
            height: 10,
            color: Colors.white,
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: navItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0)),
                        ),
                        onTap: () {
                          ref.read(indexProvider.notifier).value = index;
                          controller.animateToPage(index,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                          ref.read(discussionStateProvider.notifier).value =
                              null;
                        },
                        tileColor: indexNotifier == index
                            ? Colors.pink.shade900
                            : null,
                        leading: Icon(navItems[index]['icon'] as IconData,
                            color: indexNotifier == index
                                ? Colors.white
                                : Colors.white70),
                        title: Text(navItems[index]['name'] as String,
                            style: TextStyle(
                                color: indexNotifier == index
                                    ? Colors.white
                                    : Colors.white70)));
                  })),
        ]));
  }
}
