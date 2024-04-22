import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String id = '';
  String password = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValidated = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '로그인',
      child: SingleChildScrollView(
        // 드래그 시 text field focus 벗어남.
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Form(
                      key: formKey,
                      onChanged: () {
                        if (formKey.currentState!.validate()) {
                          isValidated = true;
                        } else {
                          isValidated = false;
                        }
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          _renderIdTextField(),
                          const SizedBox(
                            height: 20,
                          ),
                          _renderPasswordTextField(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _renderButton(),
                    const SizedBox(
                      height: 8,
                    ),
                    _renderJoinText(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderIdTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '아이디',
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFormField(
          hintText: '아이디를 입력해 주세요',
          validator: (value) {
            return Validation.validateId(value);
          },
          onChanged: (String value) {
            id = value;
          },
        ),
      ],
    );
  }

  Widget _renderPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '비밀번호',
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextFormField(
          isPassword: true,
          hintText: '비밀번호를 입력해 주세요',
          validator: (value) {
            return Validation.validatePassword(value);
          },
          onChanged: (String value) {
            password = value;
          },
        ),
      ],
    );
  }

  Widget _renderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (!isValidated) return;
          debugPrint(id);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isValidated ? primaryColor : thirdColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            '로그인',
            style: TextStyle(
              color: isValidated ? Colors.white : secondaryColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderJoinText() {
    return Row(
      children: [
        const Text(
          '아직 회원이 아니신가요?',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        GestureDetector(
          onTap: () {
            debugPrint('텍스트 탭');
          },
          child: const Text(
            '가입하기',
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
