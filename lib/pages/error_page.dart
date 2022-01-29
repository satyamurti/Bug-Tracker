import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final Object e;
  final StackTrace? trace;

  const ErrorPage({Key? key, required this.e, this.trace}) : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();
    print(widget.e);
    print(widget.trace);
  }

  @override
  build(context) => SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Text('Error: \n${widget.e}'),
                const SizedBox(height: 50),
                Text('StackTrace: \n${widget.trace}'),
              ],
            ),
          ),
        ),
      );
}
