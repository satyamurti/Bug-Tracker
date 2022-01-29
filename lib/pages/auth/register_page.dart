import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  build(context) => Scaffold(
        appBar: AppBar(title: const Text('Register')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const TextField(
                  decoration: InputDecoration(labelText: 'Username')),
              const TextField(decoration: InputDecoration(labelText: 'Email')),
              // TODO: fetch orgs list and show as spinner
              const TextField(decoration: InputDecoration(labelText: 'Org')),
              const TextField(
                  decoration: InputDecoration(labelText: 'Password')),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRegisterClick,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      );

  void onRegisterClick() {}
}
