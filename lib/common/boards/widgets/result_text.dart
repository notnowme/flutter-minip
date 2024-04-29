import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';

class ResultText extends StatelessWidget {
  const ResultText({
    super.key,
    required this.allCounts,
    required this.page,
  });

  final int allCounts;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$allCounts개의 게시글 중 $page번째 페이지',
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
