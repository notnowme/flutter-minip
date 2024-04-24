import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/date_formatting.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/views/free_read_screen.dart';

class FreeContentCard extends StatelessWidget {
  const FreeContentCard({
    super.key,
    required this.data,
  });

  final FreeListDataModel data;

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = DateTime.parse(data.created_at);

    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: thirdColor,
      ))),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed(FreeReadScreen.routeName,
                        pathParameters: {'no': '${data.no}'});
                  },
                  child: Text(
                    data.title,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '[${data.comments.length}]',
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Text(
                  Hooks.formmatingDateTime(createdAt),
                  style: const TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  '|',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  data.author.nick,
                  style: const TextStyle(
                    color: secondaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
