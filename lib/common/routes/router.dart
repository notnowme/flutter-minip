import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/views/scaffldWithNav.dart';
import 'package:minip/common/views/splash_screen.dart';
import 'package:minip/free/views/free_index.dart';
import 'package:minip/free/views/free_modify_screen.dart';
import 'package:minip/free/views/free_read_screen.dart';
import 'package:minip/free/views/free_write_screen.dart';
import 'package:minip/home/views/home_screen.dart';
import 'package:minip/user/views/join_screen.dart';
import 'package:minip/user/views/login_screen.dart';
import 'package:minip/user/views/profile_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey(debugLabel: 'root');

final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey(debugLabel: 'home');

final GlobalKey<NavigatorState> _freeBoardNavigatorKey =
    GlobalKey(debugLabel: 'free');

final GlobalKey<NavigatorState> _profileNavigatorKey =
    GlobalKey(debugLabel: 'profile');

final routesProvider = Provider(
  (ref) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/splash',
      routes: [
        GoRoute(
          path: SplashScreen.routePath,
          name: SplashScreen.routeName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: SplashScreen(),
            );
          },
        ),
        GoRoute(
          path: LoginScreen.routePath,
          name: LoginScreen.routeName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: LoginScreen(),
            );
          },
        ),
        GoRoute(
          path: JoinScreen.routePath,
          name: JoinScreen.routeName,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: JoinScreen(),
            );
          },
        ),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state, navigationShell) {
            return ScaffoldWithNav(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            _homeBranch(),
            _freeBoardBranch(),
            _profileBranch(),
          ],
        ),
      ],
    );
  },
);

StatefulShellBranch _homeBranch() {
  return StatefulShellBranch(
    navigatorKey: _homeNavigatorKey,
    routes: [
      GoRoute(
        path: HomeScreen.routePath,
        name: HomeScreen.routeName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: HomeScreen(),
          );
        },
      ),
    ],
  );
}

StatefulShellBranch _freeBoardBranch() {
  return StatefulShellBranch(
    navigatorKey: _freeBoardNavigatorKey,
    routes: [
      GoRoute(
        path: FreeIndexScreen.routePath,
        name: FreeIndexScreen.routeName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: FreeIndexScreen(),
          );
        },
        routes: [
          GoRoute(
            path: FreeWriteScreen.routePath,
            name: FreeWriteScreen.routeName,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: FreeWriteScreen(),
              );
            },
          ),
          GoRoute(
            path: FreeReadScreen.routePath,
            name: FreeReadScreen.routeName,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: FreeReadScreen(no: state.pathParameters['no']!),
              );
            },
          ),
          GoRoute(
            path: FreeModifyScreen.routePath,
            name: FreeModifyScreen.routeName,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: FreeModifyScreen(
                  no: state.pathParameters['no']!,
                  extra: state.extra,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}

StatefulShellBranch _profileBranch() {
  return StatefulShellBranch(
    navigatorKey: _profileNavigatorKey,
    routes: [
      GoRoute(
        path: ProfileScreen.routePath,
        name: ProfileScreen.routeName,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: ProfileScreen(),
          );
        },
      ),
    ],
  );
}