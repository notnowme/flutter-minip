import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/back_dialog.dart';
import 'package:minip/common/boards/widgets/custom_board_text_field.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_cmt_modify_model.dart';
import 'package:minip/free/provider/free_board_provider.dart';
import 'package:minip/free/provider/free_one_provider.dart';

class FreeCommentModifyScreen extends ConsumerWidget {
  const FreeCommentModifyScreen({
    super.key,
    required this.no,
    this.extra,
  });

  final String no;
  final Object? extra;

  static const String routeName = 'freeCmtModify';
  static const String routePath = 'cmt/modify/:no';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prevContent = extra as String;
    final contentController = TextEditingController();
    contentController.text = prevContent;
    const int maxLines = 20;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        BackAlertDialog.show(context);
      },
      child: DefaultLayout(
        title: '댓글 수정',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                modifyComment(context, contentController.text, ref, no);
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
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: maxLines * 20,
              child: CustomBoardTextFormField(
                controller: contentController,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void modifyComment(
      BuildContext context, String text, WidgetRef ref, String cmtNo) async {
    if (text.length < 4) {
      ToastMessage.showToast(context, 'error', '내용은 4글자 이상 입력해야해요');
      return;
    }
    Loading.showLoading(context);
    final result = await ref
        .read(freeBoardAsyncProvider.notifier)
        .modifyComment(cmtNo, text);
    if (context.mounted) {
      context.pop();
    }
    if (result is FreeCommentModifyModel) {
      if (context.mounted) {
        ToastMessage.showToast(context, 'success', '댓글을 수정했어요');
        ref.refresh(
            freeOneDisposeAsyncProvider(result.data.board_no.toString()));
        context.pop();
      }
    } else {
      final code = result['statusCode'];
      print(code);
    }
  }
}
