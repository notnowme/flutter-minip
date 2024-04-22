import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  String id = '', nick = '', password = '', passwordCheck = '';
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '회원 가입',
      child: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                _renderIdTextField(),
                const SizedBox(
                  height: 20,
                ),
                _renderNickTextField(),
                const SizedBox(
                  height: 20,
                ),
                _renderPasswordTextField(),
                const SizedBox(
                  height: 20,
                ),
                _renderPasswordCheckTextField(),
                const SizedBox(
                  height: 40,
                ),
                _renderButton(),
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
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: CustomTextFormField(
                  hintText: '아이디를 입력해 주세요',
                  validator: (value) {
                    return Validation.validateId(value);
                  },
                  onChanged: (String value) {
                    id = value;
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: inputBorderColodr,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _renderNickTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '닉네임',
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: CustomTextFormField(
                  hintText: '닉네임을 입력해 주세요',
                  validator: (value) {
                    return Validation.validateNick(value);
                  },
                  onChanged: (String value) {
                    nick = value;
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: inputBorderColodr,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
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
        )
      ],
    );
  }

  Widget _renderPasswordCheckTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '비밀번호 확인',
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
            return Validation.validatePasswordCheck(password, value);
          },
          onChanged: (String value) {
            passwordCheck = value;
          },
        )
      ],
    );
  }

  Widget _renderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: thirdColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            '회원 가입',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
