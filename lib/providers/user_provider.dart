import 'package:bug_tracker/models/auth/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseIdeaProvider = StreamProvider.autoDispose<List<User>>((ref) {
  final stream = FirebaseFirestore.instance.collection('users').snapshots();
  return stream.map((snapshot) => snapshot.docs.map((doc) {
        return User.fromSnapshot(doc.data());
      }).toList());
});
