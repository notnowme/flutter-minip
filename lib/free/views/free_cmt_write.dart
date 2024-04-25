import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_cmt_write_model.dart';
import 'package:minip/free/provider/free_board_provider.dart';
import 'package:minip/free/provider/free_one_provider.dart';

class FreeCommentWriteScreen extends ConsumerWidget {
  const FreeCommentWriteScreen({
    super.key,
    required this.no,
    this.extra,
  });

  final String no;
  final Object? extra;

  static const String routeName = 'freeCmtWrite';
  static const String routePath = 'free/cmt/write/:no';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardNo = extra as int;
    const int maxLines = 20;
    String contentText = '';
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: inputBorderColodr,
        width: 1,
      ),
    );
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        _showDialog(context);
      },
      child: DefaultLayout(
        title: '댓글 작성',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                writedownComment(context, contentText, ref, boardNo);
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
              child: TextFormField(
                maxLines: maxLines,
                autofocus: true,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 16,
                  decorationThickness: 0,
                ),
                cursorColor: primaryColor,
                onChanged: (value) {
                  contentText = value;
                },
                decoration: InputDecoration(
                  hintText: '내용을 입력해 주세요',
                  hintStyle: const TextStyle(
                    color: secondaryColor,
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.all(
                    10,
                  ),
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
            ),
          ),
        ),
      ),
    );
  }

  void writedownComment(
      BuildContext context, String text, WidgetRef ref, int boardNo) async {
    if (text.length < 4) {
      ToastMessage.showToast(context, 'error', '내용은 4글자 이상 입력해야해요');
      return;
    }
    final result = await ref
        .read(freeBoardAsyncProvider.notifier)
        .writeComment(boardNo, text);
    if (result is FreeCommentWriteModel) {
      if (context.mounted) {
        ToastMessage.showToast(context, 'success', '댓글을 작성했어요');
        ref.refresh(
            freeOneDisposeAsyncProvider(result.data.board_no.toString()));
        context.pop();
      }
    } else {
      final code = result['statusCode'];
      print(code);
    }
  }

  void _showDialog(BuildContext context) {
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
}
