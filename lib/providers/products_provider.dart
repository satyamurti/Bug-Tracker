import 'package:bug_tracker/models/auth/team.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Team>> getUserList() {
    try {
      return _firestore
          .collection('products')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((document) {
                var product = Team.fromJson(document.data());
                product.id = document.id;
                return product;
              }).toList());
    } catch (e) {
      rethrow;
    }
  }
}

final productProvider = Provider((ref) => ProductProvider());
