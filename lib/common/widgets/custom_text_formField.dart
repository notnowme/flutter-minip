import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.errText,
      this.isAutoFocus = false,
      this.isPassword = false,
      this.focusNode,
      this.controller,
      this.textType,
      required this.onChanged,
      required this.validator});

  final String? hintText, errText;
  final bool isPassword, isAutoFocus;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator validator;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? textType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = true;

  @override
  void initState() {
    super.initState();
    showPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: inputBorderColodr,
        width: 1,
      ),
    );
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: primaryColor,
      obscureText: showPassword,
      autofocus: widget.isAutoFocus,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.textType,
      autovalidateMode: AutovalidateMode.always,
      style: const TextStyle(
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        helperText: ' ',
        hintText: widget.hintText,
        errorText: widget.errText,
        hintStyle: const TextStyle(
          color: secondaryColor,
          fontSize: 14,
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
        focusedErrorBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: errorColor,
            width: 1,
          ),
        ),
        errorBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: errorColor,
            width: 1,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(
                    () {
                      showPassword = !showPassword;
                    },
                  );
                },
                icon: Icon(
                  showPassword
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: Colors.grey[350],
                ),
              )
            : null,
      ),
    );
  }
}
