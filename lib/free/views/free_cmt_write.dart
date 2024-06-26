import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/back_dialog.dart';
import 'package:minip/common/boards/widgets/custom_board_text_field.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_cmt_write_model.dart';
import 'package:minip/free/provider/free_board_provider.dart';
import 'package:minip/free/provider/free_one_provider.dart';
import 'package:minip/free/views/free_read_screen.dart';

class FreeCommentWriteScreen extends ConsumerWidget {
  const FreeCommentWriteScreen({
    super.key,
    required this.no,
  });

  final String no;

  static const String routeName = 'freeCmtWrite';
  static const String routePath = 'cmt/write/:no';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardNo = int.parse(no);
    bool isLoading = false;

    TextEditingController contentController = TextEditingController();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!isLoading) BackAlertDialog.show(context);
      },
      child: DefaultLayout(
          title: '댓글 작성',
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () async {
                  isLoading = true;
                  await writedownComment(
                    context,
                    contentController.text,
                    ref,
                    boardNo,
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
          child: CustomBoardTextFormField(
            controller: contentController,
          )),
    );
  }

  Future<void> writedownComment(
    BuildContext context,
    String text,
    WidgetRef ref,
    int boardNo,
  ) async {
    if (text.length < 4) {
      ToastMessage.showToast(context, 'error', '내용은 4글자 이상 입력해야해요');
      return;
    }
    Loading.showLoading(context, isRoot: true);
    final result = await ref
        .read(freeBoardAsyncProvider.notifier)
        .writeComment(boardNo, text);
    if (context.mounted) {
      while (context.canPop()) {
        context.pop();
      }
    }
    if (result is FreeCommentWriteModel) {
      if (context.mounted) {
        ToastMessage.showToast(context, 'success', '댓글을 작성했어요');
        ref.refresh(
            freeOneDisposeAsyncProvider(result.data.board_no.toString()));
        context.pushNamed(FreeReadScreen.routeName,
            pathParameters: {'no': result.data.board_no.toString()});
      }
    } else {
      final code = result['statusCode'];
      print(code);
    }
  }
}
