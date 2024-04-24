import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/free/models/free_write_model.dart';
import 'package:minip/free/provider/free_board_provider.dart';
import 'package:minip/free/provider/free_list_provider.dart';
import 'package:minip/free/views/free_read_screen.dart';
import 'package:minip/user/views/login_screen.dart';

class FreeWriteScreen extends ConsumerStatefulWidget {
  const FreeWriteScreen({super.key});

  static const String routeName = 'freeWrite';
  static const String routePath = 'write';

  static const baseBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: inputBorderColodr,
      width: 1,
    ),
  );

  @override
  ConsumerState<FreeWriteScreen> createState() => _FreeWriteScreenState();
}

class _FreeWriteScreenState extends ConsumerState<FreeWriteScreen> {
  FocusNode titleFocus = FocusNode(), contentFocus = FocusNode();
  String title = '', content = '';
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        _showDialog(context);
      },
      child: DefaultLayout(
        title: '글 작성',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                writedown();
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

  void writedown() async {
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
    final result = await ref
        .read(freeBoardAsyncProvider.notifier)
        .writedown(title, content);
    if (result is FreeWriteModel) {
      if (mounted) {
        ToastMessage.showToast(context, 'success', '글을 작성했어요');
        ref.refresh(freeListAsyncProvider('1'));
        context.pushReplacementNamed(FreeReadScreen.routeName, pathParameters: {
          'no': result.data.no.toString(),
        });
      }
    } else {
      final code = result['statusCode'];
      switch (code) {
        case 401:
          if (mounted) {
            ToastMessage.showToast(context, 'error', '다시 로그인해 주세요');
            final storage = ref.read(secureStorageProvider);
            await storage.deleteAll();
            context.goNamed(LoginScreen.routeName);
          }
          break;
      }
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
          border: FreeWriteScreen.baseBorder,
          enabledBorder: FreeWriteScreen.baseBorder,
          focusedBorder: FreeWriteScreen.baseBorder.copyWith(
            borderSide: FreeWriteScreen.baseBorder.borderSide.copyWith(
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
          border: FreeWriteScreen.baseBorder,
          enabledBorder: FreeWriteScreen.baseBorder,
          focusedBorder: FreeWriteScreen.baseBorder.copyWith(
            borderSide: FreeWriteScreen.baseBorder.borderSide.copyWith(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
