import 'package:bug_tracker/models/bug.dart';
import 'package:bug_tracker/models/bug_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BugsProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Bug>> getProductList(String productId) {
    try {
      print(productId);

      return _firestore
          .collection('bugs')
          .where('productId', isEqualTo: productId)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((document) {
                var product = Bug.fromJson(document.data());
                product.id = document.id;
                print(product.productId);
                return product;
              }).toList());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Bug>> getResolvedBugs() {
    try {
      return _firestore
          .collection('bugs')
          .where('status', isEqualTo: 'Resolved')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((document) {
                var product = Bug.fromJson(document.data());
                product.id = document.id;

                return product;
              }).toList());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resolveBug(Bug bug, WidgetRef ref) async {
    await _firestore
        .collection('bugs')
        .doc(bug.id)
        .update({"status": 'Resolved'});
    await _firestore.collection('bugs').doc(bug.id).get().then((value) {
      ref.read(discussionStateProvider.notifier).value =
          Bug.fromJson(value.data()!);
    });
  }

  Future<void> postMessage(String message, Bug bug, WidgetRef ref) async {
    var documentReference =
        _firestore.collection('users').doc(auth.currentUser!.uid).get();
    String? name;
    await documentReference.then((snapshot) {
      name = snapshot.data()!['userName'].toString();
    });
    var data = {
      'message': message,
      'name': name,
      'userId': auth.currentUser!.uid,
      'time': Timestamp.now()
    };
    await _firestore.collection('bugs').doc(bug.id).update({
      "discussion": FieldValue.arrayUnion([data])
    });
    await _firestore.collection('bugs').doc(bug.id).get().then((value) {
      ref.read(discussionStateProvider.notifier).value =
          Bug.fromJson(value.data()!);
    });
  }
}

BugDetails getBugs(List<Bug> bugs) {
  int raised = 0, resolved = 0, pending = 0;
  for (var e in bugs) {
    {
      if (e.status == "Raised") raised++;
      if (e.status == "Resolved") resolved++;
      if (e.status == "Pending") pending++;
    }
  }

  return BugDetails(bugs, raised, resolved, pending);
}

class BugStateNotifier extends StateNotifier<String> {
  BugStateNotifier() : super("");
  set value(String product) => state = product;
}

final bugStateProvider = StateNotifierProvider((ref) => BugStateNotifier());

class BugIndexStateNotifier extends StateNotifier<int> {
  BugIndexStateNotifier() : super(-1);
  set value(int index) => state = index;
}

final bugIndexProvider =
    StateNotifierProvider((ref) => BugIndexStateNotifier());

class DiscussionStateNotifier extends StateNotifier<Bug?> {
  DiscussionStateNotifier() : super(null);
  set value(Bug? product) => state = product;
}

final discussionStateProvider =
    StateNotifierProvider((ref) => DiscussionStateNotifier());

class ResolveStateNotifier extends StateNotifier<bool> {
  ResolveStateNotifier() : super(false);
  set value(bool product) => state = product;
}

final resolveStateProvider =
    StateNotifierProvider((ref) => ResolveStateNotifier());

final bugsProvider = Provider((ref) => BugsProvider());
