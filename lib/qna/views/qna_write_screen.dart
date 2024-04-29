import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_write_model.dart';
import 'package:minip/qna/provider/qna_board_provider.dart';
import 'package:minip/qna/provider/qna_list_provider.dart';
import 'package:minip/user/views/login_screen.dart';

class QnaWriteScreen extends ConsumerWidget {
  QnaWriteScreen({super.key});

  static const String routeName = 'qnaWrite';
  static const String routePath = 'write';

  static const baseBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: inputBorderColodr,
      width: 1,
    ),
  );

  final FocusNode titleFocus = FocusNode(), contentFocus = FocusNode();
  String title = '', content = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      child: DefaultLayout(
        title: '글 작성',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                // 작성
                writedown(context, ref);
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

  void writedown(BuildContext context, WidgetRef ref) async {
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
        .writedown(title, content);
    if (context.mounted) {
      context.pop();
    }
    if (result is FreeWriteModel) {
      if (context.mounted) {
        ToastMessage.showToast(context, 'success', '글을 작성했어요');
        ref.refresh(qnaListAsyncProvider(1));
        // context.pushReplacementNamed(FreeReadScreen.routeName, pathParameters: {
        //   'no': result.data.no.toString(),
        // });
      }
    } else {
      final code = result['statusCode'];
      switch (code) {
        case 401:
          if (context.mounted) {
            ToastMessage.showToast(context, 'error', '다시 로그인해 주세요');
            final storage = ref.read(secureStorageProvider);
            await storage.deleteAll();
            if (context.mounted) {
              context.goNamed(LoginScreen.routeName);
            }
          }
          break;
      }
    }
  }

  Widget _renderTitleTextField() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        focusNode: titleFocus,
        autofocus: true,
        style: const TextStyle(
          color: textColor,
          fontSize: 16,
          decorationThickness: 0,
        ),
        cursorColor: primaryColor,
        onChanged: (value) {
          title = value;
        },
        decoration: InputDecoration(
          hintText: '제목을 입력해 주세요',
          hintStyle: const TextStyle(
            color: secondaryColor,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.all(10),
          fillColor: inputBgColor,
          filled: true,
          border: QnaWriteScreen.baseBorder,
          enabledBorder: QnaWriteScreen.baseBorder,
          focusedBorder: QnaWriteScreen.baseBorder.copyWith(
            borderSide: QnaWriteScreen.baseBorder.borderSide.copyWith(
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
        maxLines: maxLines,
        autofocus: true,
        style: const TextStyle(
          color: textColor,
          fontSize: 16,
          decorationThickness: 0,
        ),
        cursorColor: primaryColor,
        onChanged: (value) {
          content = value;
        },
        decoration: InputDecoration(
          hintText: '내용을 입력해 주세요',
          hintStyle: const TextStyle(
            color: secondaryColor,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.all(10),
          fillColor: inputBgColor,
          filled: true,
          border: QnaWriteScreen.baseBorder,
          enabledBorder: QnaWriteScreen.baseBorder,
          focusedBorder: QnaWriteScreen.baseBorder.copyWith(
            borderSide: QnaWriteScreen.baseBorder.borderSide.copyWith(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
