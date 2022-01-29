import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Object e;
  final StackTrace? trace;

  const ErrorPage({Key? key, required this.e, this.trace}) : super(key: key);

  @override
  build(context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Error: \n$e'),
              const SizedBox(height: 50),
              Text('StackTrace: \n$trace'),
            ],
          ),
        ),
      );
}
