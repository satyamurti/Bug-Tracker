import 'package:bug_tracker/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: add confirm password
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController userName = TextEditingController(),
      email = TextEditingController(),
      org = TextEditingController(),
      password = TextEditingController();

  @override
  build(context) => Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: userName,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              // TODO: fetch orgs list and show as spinner
              TextField(
                controller: org,
                decoration: const InputDecoration(labelText: 'Org'),
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRegisterClick,
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> onRegisterClick() async {
    final _auth = ref.read(authenticationProvider);
    final cred = await _auth.signUpWithEmailAndPassword(
      email.text,
      password.text,
      context,
    );
    if (cred != null && cred.user != null) {
      registerUserDoc(cred.user!);
    }
  }

  Future<void> registerUserDoc(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
      {
        'id': user.uid,
        'userName': userName.text,
        'email': email.text,
        'orgId': org.text,
      },
    );
    print('user doc added');
  }
}
