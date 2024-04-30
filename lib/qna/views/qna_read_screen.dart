import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/content_render.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/qna/provider/qna_board_provider.dart';
import 'package:minip/qna/provider/qna_list_provider.dart';
import 'package:minip/qna/provider/qna_one_provider.dart';
import 'package:minip/qna/views/qna_cmt_modify.dart';
import 'package:minip/qna/views/qna_cmt_write.dart';
import 'package:minip/qna/views/qna_index.dart';
import 'package:minip/qna/views/qna_modify_screen.dart';

class QnaReadScreen extends ConsumerWidget {
  const QnaReadScreen({
    super.key,
    required this.no,
  });

  static const String routeName = 'qnaRead';
  static const String routePath = 'read/:no';
  final String no;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '질문 게시판',
      child: SingleChildScrollView(
        child: Column(
          children: [
            ref.watch(qnaOneDisposeAsyncProvider(no)).when(
              data: (data) {
                if (data is FreeOneModel) {
                  final content = data.data;
                  return BoardContent(
                    content: content,
                    routeName: QnaModifyScreen.routeName,
                    commentWriteRouterName: QnaCommentWriteScreen.routeName,
                    commentModifyRouterName: QnaCommentModifyScreen.routeName,
                    deleteContent: deleteContent,
                    deleteComment: deleteComment,
                  );
                } else {
                  return const Center(
                    child: Text('no data'),
                  );
                }
              },
              error: (err, errStack) {
                if (err is DioException) {
                  return const Center(
                    child: Text('error'),
                  );
                } else {
                  return Container();
                }
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void deleteContent(BuildContext context, WidgetRef ref) async {
    Loading.showLoading(context);
    final result =
        await ref.read(qnaBoardAsyncProvider.notifier).delete(no.toString());
    if (context.mounted) {
      context.pop();
    }
    if (result['ok']) {
      if (context.mounted) {
        ref.refresh(qnaListAsyncProvider(1));
        ToastMessage.showToast(context, 'success', '삭제했어요');
        context.goNamed(QnaIndexScreen.routeName);
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

  void deleteComment(
      BuildContext context, WidgetRef ref, int commentNo, int boardNo) async {
    Loading.showLoading(context);
    final result = await ref
        .read(qnaBoardAsyncProvider.notifier)
        .deleteComment(commentNo.toString());
    if (context.mounted) {
      context.pop();
    }
    if (result['ok']) {
      if (context.mounted) {
        ref.refresh(qnaOneDisposeAsyncProvider(boardNo.toString()));
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
