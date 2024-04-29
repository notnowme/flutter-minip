import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/date_formatting.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/provider/free_board_provider.dart';
import 'package:minip/free/provider/free_list_provider.dart';
import 'package:minip/free/provider/free_one_provider.dart';
import 'package:minip/free/views/free_cmt_modify.dart';

class FreeCommentCard extends ConsumerWidget {
  const FreeCommentCard({
    super.key,
    required this.comment,
    required this.isAuthorMe,
  });

  final FreeOneCommentsModel comment;
  final bool isAuthorMe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime createdAt = DateTime.parse(comment.created_at);
    DateTime updatedAt = DateTime.parse(comment.updated_at);

    bool isModified = createdAt != updatedAt;

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
          )
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
              FreeCommentModifyScreen.routeName,
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
                          _delete(context, ref);
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
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, WidgetRef ref) async {
    Loading.showLoading(context);
    final result = await ref
        .read(freeBoardAsyncProvider.notifier)
        .deleteComment(comment.no.toString());
    if (context.mounted) {
      context.pop();
    }
    if (result['ok']) {
      if (context.mounted) {
        ref.refresh(freeOneDisposeAsyncProvider(comment.board_no.toString()));
        ToastMessage.showToast(context, 'success', '삭제했어요');
        context.pop();
      }
    } else {
      final code = result['statusCode'];
      switch (code) {
        case 401:
          if (context.mounted) {
            ToastMessage.showToast(context, 'error', '다시 로그인해 주세요');
          }
          break;
        case 500:
          if (context.mounted) {
            ToastMessage.showToast(context, 'error', '서버 오류');
          }
          break;
      }
    }
  }
}
