import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/content_render.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_one_model.dart';
import 'package:minip/free/provider/free_board_provider.dart';
import 'package:minip/free/provider/free_list_provider.dart';
import 'package:minip/free/provider/free_one_provider.dart';
import 'package:minip/free/views/free_cmt_modify.dart';
import 'package:minip/free/views/free_cmt_write.dart';
import 'package:minip/free/views/free_index.dart';
import 'package:minip/free/views/free_modify_screen.dart';

class FreeReadScreen extends ConsumerWidget {
  const FreeReadScreen({
    super.key,
    required this.no,
  });

  static const String routeName = 'freeRead';
  static const String routePath = 'read/:no';
  final String no;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '자유 게시판',
      child: SingleChildScrollView(
        child: Column(
          children: [
            ref.watch(freeOneDisposeAsyncProvider(no)).when(
              data: (data) {
                if (data is FreeOneModel) {
                  final content = data.data;
                  return BoardContent(
                    content: content,
                    routeName: FreeModifyScreen.routeName,
                    commentWriteRouterName: FreeCommentWriteScreen.routeName,
                    commentModifyRouterName: FreeCommentModifyScreen.routeName,
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
        await ref.read(freeBoardAsyncProvider.notifier).delete(no.toString());
    if (context.mounted) {
      context.pop();
    }
    if (result['ok']) {
      if (context.mounted) {
        ref.refresh(freeListAsyncProvider(1));
        ToastMessage.showToast(context, 'success', '삭제했어요');
        context.goNamed(FreeIndexScreen.routeName);
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
        .read(freeBoardAsyncProvider.notifier)
        .deleteComment(commentNo.toString());
    if (context.mounted) {
      context.pop();
    }
    if (result['ok']) {
      if (context.mounted) {
        ref.refresh(freeOneDisposeAsyncProvider(boardNo.toString()));
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
