import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/layouts/default_layout.dart';

class FreeWriteScreen extends StatelessWidget {
  const FreeWriteScreen({super.key});

  static const baseBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: inputBorderColodr,
      width: 1,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '글 작성',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              debugPrint('작성 완료 버튼');
            },
            child: const Text(
              '완료',
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
              ),
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
    );
  }

  Widget _renderTitleTextField() {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
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
