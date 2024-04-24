import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/date_formatting.dart';
import 'package:minip/free/models/free_one_model.dart';

class FreeCommentCard extends ConsumerWidget {
  const FreeCommentCard({
    super.key,
    required this.comment,
  });

  final FreeOneCommentsModel comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime createdAt = DateTime.parse(comment.created_at);
    DateTime updatedAt = DateTime.parse(comment.updated_at);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    comment.author.nick,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  const Icon(
                    Icons.edit_document,
                    color: secondaryColor,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  const Icon(
                    Icons.delete_rounded,
                    color: errorColor,
                  ),
                ],
              ),
              const Text(
                '[수정됨]',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Text(
            Hooks.formmatingDateTime(createdAt),
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            comment.content,
            style: const TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
