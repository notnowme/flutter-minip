import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/home/views/home_screen.dart';
import 'package:minip/user/views/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splash';
  static const String routePath = '/splash';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  void checkLogin() async {
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_KEY);

    if (accessToken == null) {
      // 로그인 안 된 상태
      // 나중에 토큰이 만료됐는지 확인해야 함.
      if (mounted) {
        isLogin = false;
      }
    }
    // 로그인 된 상태
    if (mounted) {
      isLogin = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'splash',
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              if (isLogin) {
                context.goNamed(HomeScreen.routeName);
              } else {
                context.goNamed(LoginScreen.routeName);
              }
            },
            child: Text(isLogin ? '로그인 한 상태 - 홈으로' : '로그인 안 한 상태 - 로그인으로')),
      ),
    );
  }
}
