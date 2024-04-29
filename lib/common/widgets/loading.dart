import 'package:flutter/material.dart';

class Loading {
  static void showLoading(BuildContext context) {
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
