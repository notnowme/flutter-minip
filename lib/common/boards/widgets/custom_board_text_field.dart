import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';

class CustomBoardTextFormField extends StatelessWidget {
  const CustomBoardTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  final baseBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: inputBorderColodr,
      width: 1,
    ),
  );
  @override
  Widget build(BuildContext context) {
    const int maxLines = 20;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: SizedBox(
          width: double.infinity,
          height: maxLines * 20,
          child: TextFormField(
            controller: controller,
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
    );
  }
}
