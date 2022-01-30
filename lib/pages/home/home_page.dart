import 'package:bug_tracker/pages/error_page.dart';
import 'package:bug_tracker/pages/home/widgets/nav_bar.dart';
import 'package:bug_tracker/pages/loading_page.dart';
import 'package:bug_tracker/providers/auth_provider.dart';
import 'package:bug_tracker/providers/navigation_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String get uid => ref.read(authenticationProvider).currentUser!.uid;

  late FutureProvider<Map<String, dynamic>> userInfoProvider;

  @override
  void initState() {
    super.initState();
    userInfoProvider = FutureProvider((ref) async {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return doc.data()!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        final asyncValue = ref.watch(userInfoProvider);
        return asyncValue.map(
          data: (date) => content(controller),
          loading: (_) => const LoadingPage(),
          error: (error) => ErrorPage(
            e: error.error,
            trace: error.stackTrace,
          ),
        );
        // return ;
      }),
    );
  }

  Row content(PageController controller) => Row(
        children: [
          Flexible(flex: 2, child: NavBar(controller: controller)),
          Flexible(
            flex: 8,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: false,
              controller: controller,
              children: navScreens,
            ),
          )
        ],
      );

  Widget debugContent(Map<String, dynamic> userInfo) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userInfo.toString()),
            ElevatedButton(
              onPressed: () {
                final auth = ref.watch(authenticationProvider);
                auth.signOut();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      );
}
