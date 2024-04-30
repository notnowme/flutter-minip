import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_modify_model.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/qna/provider/qna_board_provider.dart';
import 'package:minip/qna/provider/qna_list_provider.dart';
import 'package:minip/qna/provider/qna_one_provider.dart';
import 'package:minip/qna/views/qna_read_screen.dart';

class QnaModifyScreen extends ConsumerWidget {
  QnaModifyScreen({
    super.key,
    required this.no,
    this.extra,
  });

  static const String routeName = 'qnaModify';
  static const String routePath = 'modify/:no';

  final String no;
  final Object? extra;

  final baseBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: inputBorderColodr,
      width: 1,
    ),
  );
  bool isModified = false;

  final TextEditingController titleController = TextEditingController(),
      contentController = TextEditingController();
  FocusNode titleFocus = FocusNode(), contentFocus = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusNode titleFocus = FocusNode(), contentFocus = FocusNode();

    final prevContent = extra as FreeOneDataModel;
    titleController.text = prevContent.title;
    contentController.text = prevContent.content;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!isModified) _showBackDialog(context);
      },
      child: DefaultLayout(
        title: '글 수정',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                await modify(
                  context,
                  ref,
                  prevContent.no.toString(),
                );
              },
              child: const Icon(
                Icons.edit_document,
                color: primaryColor,
              ),
            ),
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                _renderTitleTextField(),
                const SizedBox(
                  height: 40,
                ),
                _renderContentTextField(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBackDialog(BuildContext context) {
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
                  '작성한 정보는 저장되지 않아요',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 22,
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
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pop();
                        context.pop();
                      },
                      child: const Text(
                        '돌아가기',
                        style: TextStyle(
                          color: primaryColor,
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

  Future<void> modify(BuildContext context, WidgetRef ref, String no) async {
    final title = titleController.text;
    final content = contentController.text;

    if (title.length < 4) {
      ToastMessage.showToast(context, 'error', '제목은 4글자 이상 입력해야해요');
      titleFocus.requestFocus();
      return;
    }
    if (content.length < 4) {
      ToastMessage.showToast(context, 'error', '내용은 4글자 이상 입력해야해요');
      contentFocus.requestFocus();
      return;
    }
    Loading.showLoading(context);
    final result = await ref
        .read(qnaBoardAsyncProvider.notifier)
        .modify(title, content, no);
    if (context.mounted) {
      context.pop();
    }
    if (result is FreeModifyModel) {
      if (context.mounted) {
        isModified = true;
        ToastMessage.showToast(context, 'success', '글을 수정했어요');
        ref.refresh(qnaListAsyncProvider(1));
        ref.refresh(qnaOneDisposeAsyncProvider(result.data.no.toString()));
        context.goNamed(
          QnaReadScreen.routeName,
          pathParameters: {
            'no': result.data.no.toString(),
          },
        );
      }
    }
  }

  Widget _renderTitleTextField() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        focusNode: titleFocus,
        controller: titleController,
        autofocus: true,
        style: const TextStyle(
          color: textColor,
          fontSize: 16,
          decorationThickness: 0,
        ),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: '제목을 입력해 주세요',
          hintStyle: const TextStyle(
            color: secondaryColor,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.all(10),
          fillColor: inputBgColor,
          filled: true,
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderContentTextField() {
    const int maxLines = 20;
    return SizedBox(
      width: double.infinity,
      height: maxLines * 20,
      child: TextFormField(
        focusNode: contentFocus,
        controller: contentController,
        maxLines: maxLines,
        autofocus: true,
        style: const TextStyle(
          color: textColor,
          fontSize: 16,
          decorationThickness: 0,
        ),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: '내용을 입력해 주세요',
          hintStyle: const TextStyle(
            color: secondaryColor,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.all(10),
          fillColor: inputBgColor,
          filled: true,
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
