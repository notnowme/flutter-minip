import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/date_formatting.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/views/free_modify_screen.dart';
import 'package:minip/free/widgets/free_comments_render.dart';

class RenderBoardContent extends StatelessWidget {
  const RenderBoardContent({
    super.key,
    required this.content,
  });

  final FreeOneDataModel content;

  @override
  Widget build(BuildContext context) {
    final DateTime createdAt = DateTime.parse(content.created_at);
    final DateTime updatedAt = DateTime.parse(content.updated_at);

    final bool isModified = createdAt != updatedAt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        content.title,
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        isModified ? '[수정됨]' : '',
                        style: const TextStyle(
                          color: textColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          // 수정 페이지 이동
                          context.pushNamed(FreeModifyScreen.routeName,
                              pathParameters: {'no': content.no.toString()},
                              extra: content);
                        },
                        child: const Icon(
                          Icons.edit_note_rounded,
                          size: 24,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          // 게시글 삭제
                          _showDeleteDialog(context);
                        },
                        child: const Icon(
                          Icons.delete_rounded,
                          size: 24,
                          color: errorColor,
                        ),
                      ),
                    ],
                  )
                ],
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
                    content.author.nick,
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                content.content,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 10,
          decoration: const BoxDecoration(
            color: thirdColor,
          ),
        ),
        FreeCommentsList(comments: content.comments),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context) {
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
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '게시글 삭제',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '정말 삭제할까요?',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
