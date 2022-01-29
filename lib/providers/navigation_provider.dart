import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavStateNotifier extends StateNotifier<int> {
  NavStateNotifier() : super(0);
  set value(int index) => state = index;
}

final indexProvider = StateNotifierProvider((ref) => NavStateNotifier());

final navItems = [
  {'name': 'Dashboard', 'icon': Icons.dashboard},
  {'name': 'Bugs', 'icon': Icons.bug_report_sharp},
  {'name': 'Teams', 'icon': Icons.group}
];

const List<Widget> navScreens = [
  Center(child: Text('DashBoard')),
  Center(child: Text('Bugs')),
  Center(child: Text('Teams')),
];
