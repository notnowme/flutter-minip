import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/widgets/boxBorderLayout.dart';
import 'package:minip/home/models/board_recent_model.dart';

class RecentContent extends ConsumerWidget {
  const RecentContent({
    super.key,
    required this.content,
    required this.routeReadName,
  });

  final RecentBoardDataModel content;
  final String routeReadName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int commentCount = content.comments.length;
    return BoxBorderLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 210,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      content.title,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: textColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    commentCount > 0 ? '[$commentCount]' : '',
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                context.goNamed(
                  routeReadName,
                  pathParameters: {
                    'no': content.no.toString(),
                  },
                );
              },
              child: const Icon(
                Icons.chevron_right_rounded,
                size: 28,
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
