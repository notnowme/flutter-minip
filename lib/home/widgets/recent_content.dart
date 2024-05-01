import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/widgets/boxBorderLayout.dart';
import 'package:minip/home/models/board_recent_model.dart';

class RecentContent extends ConsumerWidget {
  const RecentContent({
    super.key,
    required this.content,
  });

  final RecentBoardDataModel content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BoxBorderLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content.title,
              style: const TextStyle(
                color: textColor,
                fontSize: 18,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 28,
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
