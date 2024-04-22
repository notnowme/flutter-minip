import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/user/widgets/boxBorderLayout.dart';

class BoardInfoWidget extends StatelessWidget {
  const BoardInfoWidget({super.key, required this.boardName});

  final String boardName;

  @override
  Widget build(BuildContext context) {
    return BoxBorderLayout(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              boardName,
              style: const TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  _renderCountInfo('게시글', 10),
                  const SizedBox(
                    width: 20,
                  ),
                  _renderVerticalLine(),
                  const SizedBox(
                    width: 20,
                  ),
                  _renderCountInfo('댓글', 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _renderCountInfo(String type, int count) {
    return Column(
      children: [
        Text(
          type,
          style: const TextStyle(
            color: secondaryColor,
            fontSize: 16,
          ),
        ),
        Text(
          '$count',
          style: const TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _renderVerticalLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        width: 1,
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: thirdColor,
        )),
      ),
    );
  }
}
