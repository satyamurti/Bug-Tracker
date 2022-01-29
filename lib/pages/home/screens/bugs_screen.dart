import 'package:bug_tracker/pages/home/screens/product_details.dart';
import 'package:bug_tracker/pages/home/screens/product_list.dart';
import 'package:flutter/material.dart';

class BugScreen extends StatelessWidget {
  const BugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(flex: 3, child: ProductsList()),
        const Expanded(flex: 8, child: ProductDetails())
      ],
    );
  }
}
