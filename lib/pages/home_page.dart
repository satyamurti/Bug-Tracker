import 'package:bug_tracker/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: Consumer(
            builder: (context, ref, _) => ElevatedButton(
              onPressed: () {
                final auth = ref.watch(authenticationProvider);
                auth.signOut();
              },
              child: const Text('Logout'),
            ),
          ),
        ),
      );
}
