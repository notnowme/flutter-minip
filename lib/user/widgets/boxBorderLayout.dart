import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';

class BoxBorderLayout extends StatelessWidget {
  const BoxBorderLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: thirdColor,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: child,
    );
  }
}
