import 'package:bug_tracker/models/auth/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseIdeaProvider = StreamProvider.autoDispose<List<UserInfo>>((ref) {
  final stream = FirebaseFirestore.instance.collection('users').snapshots();
  return stream.map((snapshot) => snapshot.docs.map((doc) {
        print(doc.data());
        return UserInfo.fromMap(doc.data());
      }).toList());
});
