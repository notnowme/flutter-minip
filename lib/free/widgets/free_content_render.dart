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
import 'package:minip/free/views/free_index.dart';
import 'package:minip/free/views/free_modify_screen.dart';
import 'package:minip/free/widgets/free_comments_render.dart';
import 'package:minip/user/provider/user_data_provider.dart';

class RenderBoardContent extends ConsumerStatefulWidget {
  const RenderBoardContent({
    super.key,
    required this.content,
  });

  final FreeOneDataModel content;

  @override
  ConsumerState<RenderBoardContent> createState() => _RenderBoardContentState();
}

class _RenderBoardContentState extends ConsumerState<RenderBoardContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime createdAt = DateTime.parse(widget.content.created_at);
    final DateTime updatedAt = DateTime.parse(widget.content.updated_at);
    String? myId;
    ref.watch(userDataAsyncNotifier).when(
      data: (data) {
        if (data != null) {
          myId = data.id;
        }
      },
      error: (err, errStack) {
        print(err);
      },
      loading: () {
        print('loading');
      },
    );

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
                        widget.content.title,
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
                  renderMenuButton(myId),
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
                    widget.content.author.nick,
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
                widget.content.content,
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
        FreeCommentsList(
          comments: widget.content.comments,
          boardNo: widget.content.no,
          myId: myId,
        ),
      ],
    );
  }

  Widget renderMenuButton(String? id) {
    // final userData = await ref.read(userDataAsyncNotifier.notifier).getMe();
    if (id == null || id != widget.content.author.id) {
      return Container();
    }
    return Row(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            // 수정 페이지 이동
            context.pushNamed(FreeModifyScreen.routeName,
                pathParameters: {'no': widget.content.no.toString()},
                extra: widget.content);
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
    );
  }

  void _showDeleteDialog(BuildContext context) {
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
                          _delete();
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

  void _delete() async {
    Loading.showLoading(context);
    final result = await ref
        .read(freeBoardAsyncProvider.notifier)
        .delete(widget.content.no.toString());
    if (mounted) {
      context.pop();
    }
    if (result['ok']) {
      if (mounted) {
        ref.refresh(freeListAsyncProvider(1));
        ToastMessage.showToast(context, 'success', '삭제했어요');
        context.goNamed(FreeIndexScreen.routeName);
      }
    } else {
      final code = result['statusCode'];
      switch (code) {
        case 401:
          if (mounted) {
            ToastMessage.showToast(context, 'error', '다시 로그인해 주세요');
          }
          break;
        case 500:
          if (mounted) {
            ToastMessage.showToast(context, 'error', '서버 오류');
          }
          break;
      }
    }
  }
}
