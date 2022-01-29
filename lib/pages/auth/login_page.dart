import 'package:bug_tracker/pages/auth/register_page.dart';
import 'package:bug_tracker/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController(),
      password = TextEditingController();

  @override
  build(context) => Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, _) => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final auth = ref.watch(authenticationProvider);
                      auth.signInWithEmailAndPassword(
                        email.text,
                        password.text,
                        context,
                      );
                    },
                    child: const Text('Login'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: onRegisterClick,
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      );

  void onRegisterClick() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => RegisterPage()));
}
