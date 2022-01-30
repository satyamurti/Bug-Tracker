import 'package:bug_tracker/pages/auth_checker.dart';
import 'package:bug_tracker/pages/create_product/create_product_page.dart';
import 'package:bug_tracker/pages/error_page.dart';
import 'package:bug_tracker/pages/loading_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((_) async {
  if (kIsWeb) {
    return await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCED4XxKF-CwkKPoV0vLKS5a28c1t8jKd0",
        authDomain: "bug-tracker-86a80.firebaseapp.com",
        projectId: "bug-tracker-86a80",
        storageBucket: "bug-tracker-86a80.appspot.com",
        messagingSenderId: "939078485865",
        appId: "1:939078485865:web:f3d43ffecd7841bc931ff8",
        measurementId: "G-ZXNRFFY0M4",
      ),
    );
  }
  return await Firebase.initializeApp();
});

// TODO: add form validation
class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialize.when(
        data: (data) => AuthChecker(),
        loading: () => const LoadingPage(),
        error: (e, stackTrace) => ErrorPage(
          e: e,
          trace: stackTrace,
        ),
      ),
    );
  }
}
