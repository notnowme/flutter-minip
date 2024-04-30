import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/qna/widgets/page_button.dart';
import 'package:minip/common/const/colors.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key, required this.provider});

  final AsyncNotifierProviderFamily provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.cancel_presentation_rounded,
            size: 92,
            color: thirdColor,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            '게시물 결과가 없어요',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PageMoveButton(provider: provider),
        ],
      ),
    );
  }
}
