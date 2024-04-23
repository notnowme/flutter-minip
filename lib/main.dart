import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/routes/router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: _MyApp(),
    ),
  );
}

class _MyApp extends ConsumerWidget {
  const _MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routesProvider),
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      title: 'CRUD',
      debugShowCheckedModeBanner: false,
    );
  }
}
