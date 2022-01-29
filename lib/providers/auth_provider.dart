import 'package:bug_tracker/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider =
    Provider<Authentication>((ref) => Authentication());

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.read(authenticationProvider).authStateChange);
