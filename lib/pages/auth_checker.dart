import 'package:bug_tracker/pages/auth/login_page.dart';
import 'package:bug_tracker/pages/error_page.dart';
import 'package:bug_tracker/pages/loading_page.dart';
import 'package:bug_tracker/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
      data: (data) {
        if (data != null) return const HomePage();
        return const LoginPage();
      },
      loading: () => const LoadingPage(),
      error: (e, trace) => ErrorPage(
        e: e,
        trace: trace,
      ),
    );
  }
}
