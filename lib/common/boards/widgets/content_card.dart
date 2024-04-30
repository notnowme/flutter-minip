import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/date_formatting.dart';
import 'package:minip/free/models/free_list_model.dart';

class ContentCard extends ConsumerWidget {
  const ContentCard({
    super.key,
    required this.data,
    required this.routeName,
  });

  final FreeListDataModel data;
  final String routeName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime createdAt = DateTime.parse(data.created_at);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: thirdColor,
          ),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: [
            _renderTitleAndComment(context),
            const SizedBox(
              height: 2,
            ),
            _renderDateAndNick(createdAt),
          ],
        ),
      ),
    );
  }

  Widget _renderTitleAndComment(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.pushNamed(
              routeName,
              pathParameters: {'no': '${data.no}'},
            );
          },
          child: Text(
            data.title,
            style: const TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
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
    );
  }

  Widget _renderDateAndNick(DateTime createdAt) {
    return Row(
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
    );
  }
}
