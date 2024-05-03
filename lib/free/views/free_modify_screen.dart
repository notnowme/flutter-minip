import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/back_dialog.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_modify_model.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/provider/free_board_provider.dart';
import 'package:minip/free/provider/free_list_provider.dart';
import 'package:minip/free/provider/free_one_provider.dart';
import 'package:minip/free/views/free_read_screen.dart';

class FreeModifyScreen extends ConsumerWidget {
  FreeModifyScreen({
    super.key,
    required this.no,
    this.extra,
  });

  static const String routeName = 'freeModify';
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
  bool isLoading = false;

  final TextEditingController titleController = TextEditingController(),
      contentController = TextEditingController();
  FocusNode titleFocus = FocusNode(), contentFocus = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prevContent = extra as FreeOneDataModel;
    titleController.text = prevContent.title;
    contentController.text = prevContent.content;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!isModified && !isLoading) BackAlertDialog.show(context);
      },
      child: DefaultLayout(
        title: '글 수정',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                isLoading = true;
                await modify(
                  context,
                  ref,
                  prevContent.no.toString(),
                );
                isLoading = false;
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
    Loading.showLoading(context, isRoot: true);
    final result = await ref
        .read(freeBoardAsyncProvider.notifier)
        .modify(title, content, no);
    if (context.mounted) {
      while (context.canPop()) {
        context.pop();
      }
    }
    if (result is FreeModifyModel) {
      if (context.mounted) {
        isModified = true;
        ToastMessage.showToast(context, 'success', '글을 수정했어요');
        ref.refresh(freeListAsyncProvider(1));
        ref.refresh(freeOneDisposeAsyncProvider(result.data.no.toString()));
        context.goNamed(
          FreeReadScreen.routeName,
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
