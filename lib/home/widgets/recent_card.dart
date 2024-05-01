import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/widgets/boxBorderLayout.dart';
import 'package:minip/home/models/board_recent_model.dart';
import 'package:minip/home/widgets/recent_content.dart';

class RecentCard extends ConsumerWidget {
  const RecentCard({
    super.key,
    required this.content,
    required this.boardTitle,
  });

  final List<RecentBoardDataModel> content;
  final String boardTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BoxBorderLayout(
      child: Padding(
        padding: const EdgeInsets.all(
          10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  boardTitle,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  '더 보기',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: content.length,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemBuilder: (context, index) {
                var data = content[index];
                return RecentContent(
                  content: data,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
