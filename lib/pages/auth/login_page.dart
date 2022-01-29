import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  build(context) => Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const TextField(decoration: InputDecoration(labelText: 'Email')),
              const TextField(
                  decoration: InputDecoration(labelText: 'Password')),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onLoginClick,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      );

  void onLoginClick() {}
}
