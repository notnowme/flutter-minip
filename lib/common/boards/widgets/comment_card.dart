import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/date_formatting.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/free/models/free_one_model.dart';

class CommentCard extends ConsumerWidget {
  const CommentCard({
    super.key,
    required this.comment,
    required this.isAuthorMe,
    required this.routeName,
    required this.commentModifyRouterName,
    required this.deleteComment,
  });

  final FreeOneCommentsModel comment;
  final bool isAuthorMe;
  final String routeName;
  final String commentModifyRouterName;
  final Function deleteComment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime createdAt = DateTime.parse(comment.created_at);
    DateTime updatedAt = DateTime.parse(comment.updated_at);

    bool isModified = createdAt != updatedAt;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
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
                  renderMenuButton(context, ref),
                ],
              ),
              Text(
                isModified ? '[수정됨]' : '',
                style: const TextStyle(
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
          ),
        ],
      ),
    );
  }

  Widget renderMenuButton(BuildContext context, WidgetRef ref) {
    if (!isAuthorMe) {
      return Container();
    }
    return Row(
      children: [
        const SizedBox(
          width: 14,
        ),
        GestureDetector(
          onTap: () {
            // 댓글 수정 페이지 이동
            context.pushNamed(
              commentModifyRouterName,
              pathParameters: {
                'no': comment.no.toString(),
              },
              extra: comment.content,
            );
          },
          child: const Icon(
            Icons.edit_document,
            color: secondaryColor,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        GestureDetector(
          onTap: () {
            _showDeleteDialog(context, ref);
          },
          child: const Icon(
            Icons.delete_rounded,
            color: errorColor,
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> checkKey = GlobalKey();
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          surfaceTintColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(15),
          content: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: inputBorderColodr,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '댓글 삭제',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  '정말 삭제할까요?',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\'삭제합니다\'',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '를 입력해 주세요',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: checkKey,
                  child: CustomTextFormField(
                    onChanged: (value) {},
                    validator: (value) => Validation.validateDeleteCheck(value),
                    hintText: '삭제합니다',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Text(
                        '취소',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (checkKey.currentState!.validate()) {
                          deleteComment(
                            context,
                            ref,
                            comment.no,
                            comment.board_no,
                          );
                        }
                      },
                      child: const Text(
                        '삭제',
                        style: TextStyle(
                          color: errorColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
