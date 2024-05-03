import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/comment_list.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/date_formatting.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/user/provider/user_data_provider.dart';

class BoardContent extends ConsumerWidget {
  const BoardContent({
    super.key,
    required this.content,
    required this.routeName,
    required this.commentWriteRouterName,
    required this.commentModifyRouterName,
    required this.deleteContent,
    required this.deleteComment,
  });

  final FreeOneDataModel content;
  final String routeName;
  final String commentWriteRouterName;
  final String commentModifyRouterName;
  final Function deleteContent;
  final Function deleteComment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime createdAt = DateTime.parse(content.created_at);
    final DateTime updatedAt = DateTime.parse(content.updated_at);

    final bool isModified = createdAt != updatedAt;

    return ref.watch(userDataAsyncNotifier).when(
      data: (data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    isModified ? '[수정됨]' : '',
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 10,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 110,
                        child: Text(
                          content.title,
                          style: const TextStyle(
                            color: textColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      _renderMenuButton(data?.id, context, ref),
                    ],
                  ),
                  _renderDateAndNick(createdAt),
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
            CommentList(
              comments: content.comments,
              boardNo: content.no,
              myId: data?.id,
              routeName: commentWriteRouterName,
              commentModifyRouterName: commentModifyRouterName,
              deleteComment: deleteComment,
            ),
          ],
        );
      },
      error: (err, errStack) {
        return const Center(
          child: Text('Something error...'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _renderMenuButton(String? id, BuildContext context, WidgetRef ref) {
    if (id == null || id != content.author.id) {
      return Container();
    }
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            // 수정 페이지 이동
            context.pushNamed(
              routeName,
              pathParameters: {
                'no': content.no.toString(),
              },
              extra: content,
            );
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
            _showDeleteDialog(context, ref);
          },
          child: const Icon(
            Icons.delete_rounded,
            size: 24,
            color: errorColor,
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
          content.author.nick,
          style: const TextStyle(
            color: secondaryColor,
            fontSize: 12,
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
      builder: (context) {
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
                  '게시글 삭제',
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
                          await deleteContent(context, ref);
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
