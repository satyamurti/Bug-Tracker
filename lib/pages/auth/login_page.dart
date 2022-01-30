import 'package:bug_tracker/pages/auth/register_page.dart';
import 'package:bug_tracker/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController email = TextEditingController(),
      password = TextEditingController();

  @override
  build(context) => Scaffold(
          body: Row(children: [
        Flexible(
            child: Container(
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LOGIN',
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(height: 10),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink.shade900),
                      fixedSize: MaterialStateProperty.all(Size(50, 50))),
                  onPressed: onLoginClick,
                  child: const Text('Login'),
                ),
              ),
              const Divider(
                height: 20,
                color: Colors.black,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: onRegisterClick,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink.shade100),
                      fixedSize: MaterialStateProperty.all(Size(50, 50))),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        )),
        Flexible(child: SvgPicture.asset('assets/bug3.svg'))
      ]));

  void onLoginClick() {
    final auth = ref.read(authenticationProvider);
    auth.signInWithEmailAndPassword(
      email.text,
      password.text,
      context,
    );
  }

  void onRegisterClick() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => RegisterPage()));
}
