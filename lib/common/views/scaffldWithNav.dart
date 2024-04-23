import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';

const Map<int, String> navIndexEndPointMapper = {
  0: '/',
  1: '/profile',
};

class ScaffoldWithNav extends StatefulWidget {
  const ScaffoldWithNav({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;
  @override
  State<ScaffoldWithNav> createState() => _ScaffoldWithNavState();
}

class _ScaffoldWithNavState extends State<ScaffoldWithNav> {
  int currentIndex = 0;

  void onTapButtonNavigation(int index) {
    final hasAlreadyOnBranch = index == widget.navigationShell.currentIndex;

    if (hasAlreadyOnBranch) {
      context.go(navIndexEndPointMapper[index]!);
    } else {
      widget.navigationShell.goBranch(index);
    }
  }

  void _initNavigationIndex(BuildContext context) {
    final routerState = GoRouterState.of(context);
    late int index;

    for (final entry in navIndexEndPointMapper.entries) {
      if (routerState.fullPath!.startsWith(entry.value)) {
        index = entry.key;
      }
    }
    setState(
      () {
        currentIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _initNavigationIndex(context);

    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapButtonNavigation,
        selectedItemColor: primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
            ),
            label: '프로필',
          ),
        ],
      ),
      child: widget.navigationShell,
    );
  }
}
