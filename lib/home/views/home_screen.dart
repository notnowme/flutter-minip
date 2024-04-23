import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/user/views/profile_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';
  static const String routePath = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '홈',
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            context.goNamed(ProfileScreen.routeName);
          },
          child: const Text('go profile'),
        ),
      ),
    );
  }
}
