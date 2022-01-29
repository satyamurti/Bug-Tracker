import 'package:bug_tracker/pages/home/widgets/nav_bar.dart';
import 'package:bug_tracker/providers/navigation_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
        body: Row(children: [
      Flexible(flex: 2, child: NavBar(controller: controller)),
      Flexible(
          flex: 8,
          child: PageView(
              pageSnapping: false,
              scrollDirection: Axis.vertical,
              controller: controller,
              children: navScreens))
    ]));
  }
}
