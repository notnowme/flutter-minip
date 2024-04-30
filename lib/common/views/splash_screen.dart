import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/home/views/home_screen.dart';
import 'package:minip/user/models/auth_model.dart';
import 'package:minip/user/provider/join_provider.dart';
import 'package:minip/user/views/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splash';
  static const String routePath = '/splash';

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with WidgetsBindingObserver {
  bool isLogin = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    checkLogin();
    // ref.read(joinAsyncProvider.notifier).checkToken();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       initState();
  //       print('bb');
  //       break;
  //     case AppLifecycleState.inactive:
  //       print('cc');
  //       break;
  //     case AppLifecycleState.hidden:
  //       print('dd');
  //     case AppLifecycleState.paused:
  //       print('hihi');
  //       break;
  //     case AppLifecycleState.detached:
  //       print('aa');
  //       break;
  //   }
  // }

  void checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final storage = ref.read(secureStorageProvider);
    final accessToken = await storage.read(key: ACCESS_KEY);

    if (accessToken == null) {
      if (mounted) {
        context.goNamed(LoginScreen.routeName);
      }
    } else {
      ref.read(joinAsyncProvider.notifier).checkToken();
      // 로그인 된 상태
      if (mounted) {
        final result = await ref.watch(joinAsyncProvider.notifier).checkToken();
        if (result is AuthModel) {
          if (result.message.isEmpty) {
            if (mounted) {
              context.goNamed(HomeScreen.routeName);
            }
          }
        } else {
          if (mounted) {
            context.goNamed(LoginScreen.routeName);
          }
        }
      }
    }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '유저 정보를 확인하고 있어요...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
