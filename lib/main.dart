import 'package:bug_tracker/pages/auth/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCED4XxKF-CwkKPoV0vLKS5a28c1t8jKd0",
          authDomain: "bug-tracker-86a80.firebaseapp.com",
          projectId: "bug-tracker-86a80",
          storageBucket: "bug-tracker-86a80.appspot.com",
          messagingSenderId: "939078485865",
          appId: "1:939078485865:web:f3d43ffecd7841bc931ff8",
          measurementId: "G-ZXNRFFY0M4"),
    );
  }
  runApp(const MyApp());
}

// TODO: add form validation
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  build(context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const RegisterPage(),
      );
}
