import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Loading {
  static void showLoading(BuildContext context, {bool isRoot = false}) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: isRoot,
      context: context,
      builder: (_) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          content: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
