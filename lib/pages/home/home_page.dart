import 'package:bug_tracker/models/auth/product.dart';
import 'package:bug_tracker/models/auth/user_info.dart';
import 'package:bug_tracker/pages/error_page.dart';
import 'package:bug_tracker/pages/home/new_bug_page.dart';
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

final userInfoProvider = FutureProvider.family((ref, String id) async {
  final doc =
      await FirebaseFirestore.instance.collection('users').doc(id).get();
  return UserInfo.fromMap(doc.data()!);
});

class _HomePageState extends ConsumerState<HomePage> {
  String get uid => ref.read(authenticationProvider).currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      body: ref.watch(userInfoProvider(uid)).map(
            // TODO: remove this in the end
            data: (data) => NewBugPage(
              userInfo: data.value,
              product: Product(
                '1',
                '2',
                'Dalal Street',
                'Best Pragyan Event',
                ['Siva', 'Satya'],
                ['Ajitha', 'Dhruv', 'Sailesh'],
              ),
            ),
            loading: (_) => const LoadingPage(),
            error: (error) => ErrorPage(
              e: error.error,
              trace: error.stackTrace,
            ),
          ),
        );
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

  Widget debugContent(UserInfo userInfo) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('username = ${userInfo.userName}'),
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
