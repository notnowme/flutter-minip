import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/back_dialog.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/user/models/join_data_model.dart';
import 'package:minip/user/provider/join_provider.dart';
import 'package:minip/user/views/login_screen.dart';

class JoinScreen extends ConsumerStatefulWidget {
  const JoinScreen({super.key});

  static const String routeName = 'join';
  static const String routePath = '/join';

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  String id = '', nick = '', password = '', passwordCheck = '';

  bool isIdValid = false,
      isNickValid = false,
      isPwValid = false,
      isPwChkValid = false;

  bool idChecked = false, nickChecked = false;

  FocusNode idFocus = FocusNode(), nickFocus = FocusNode();

  bool isModified = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!isModified) BackAlertDialog.show(context);
      },
      child: DefaultLayout(
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
      ),
    );
  }

  Widget _renderIdTextField() {
    void checkId() async {
      final result = await ref.read(joinAsyncProvider.notifier).checkId(id);
      if (result['ok']) {
        if (mounted) {
          ToastMessage.showToast(context, 'success', '가입할 수 있는 아이디예요');
        }
        setState(() {
          idChecked = true;
        });
      } else {
        final code = result['statusCode'];
        setState(() {
          idChecked = false;
        });
        switch (code) {
          case 409:
            if (mounted) {
              ToastMessage.showToast(context, 'error', '이미 있는 아이디예요');
              idFocus.requestFocus();
            }
            break;
        }
      }
    }

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
                  focusNode: idFocus,
                  hintText: '아이디를 입력해 주세요',
                  validator: (value) {
                    return Validation.validateId(value);
                  },
                  onChanged: (String value) {
                    id = value;
                    if (Validation.validateId(value) == null) {
                      isIdValid = true;
                    } else {
                      isIdValid = false;
                    }
                    setState(() {
                      idChecked = false;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!isIdValid) return;
                  checkId();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: isIdValid ? primaryColor : thirdColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: inputBorderColodr,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: isIdValid ? Colors.white : secondaryColor,
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
    void checkNick() async {
      final result = await ref.read(joinAsyncProvider.notifier).checkNick(nick);
      if (result['ok']) {
        if (mounted) {
          ToastMessage.showToast(context, 'success', '가입할 수 있는 닉네임이에요');
        }
        setState(() {
          nickChecked = true;
        });
      } else {
        final code = result['statusCode'];
        setState(() {
          nickChecked = false;
        });
        switch (code) {
          case 409:
            if (mounted) {
              ToastMessage.showToast(context, 'error', '이미 있는 닉네임이에요');
              nickFocus.requestFocus();
            }
            break;
        }
      }
    }

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
                  focusNode: nickFocus,
                  hintText: '닉네임을 입력해 주세요',
                  validator: (value) {
                    return Validation.validateNick(value);
                  },
                  onChanged: (String value) {
                    nick = value;
                    if (Validation.validateNick(value) == null) {
                      isNickValid = true;
                    } else {
                      isNickValid = false;
                    }
                    setState(() {
                      nickChecked = false;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!isNickValid) return;
                  checkNick();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: isNickValid ? primaryColor : thirdColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  side: const BorderSide(
                    color: inputBorderColodr,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: isNickValid ? Colors.white : secondaryColor,
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
            if (Validation.validatePassword(value) == null) {
              isPwValid = true;
            } else {
              isPwValid = false;
            }
            setState(() {});
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
            if (Validation.validatePasswordCheck(password, value) == null) {
              isPwChkValid = true;
            } else {
              isPwChkValid = false;
            }
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _renderButton() {
    bool isAllValid = idChecked && nickChecked && isPwValid && isPwChkValid;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (!isAllValid) return;
          signUp();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isAllValid ? primaryColor : thirdColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            '회원 가입',
            style: TextStyle(
              color: isAllValid ? Colors.white : secondaryColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    JoinDataModel user = JoinDataModel(
      id: id,
      nick: nick,
      password: password,
    );
    Loading.showLoading(context);
    final result = await ref.read(joinAsyncProvider.notifier).join(user);
    if (mounted) {
      context.pop();
    }
    if (result['ok']) {
      if (mounted) {
        isModified = true;
        ToastMessage.showToast(context, 'success', '가입에 성공했어요');
        context.goNamed(LoginScreen.routeName);
      }
    } else {
      final code = result['statusCode'];
      print(code);
    }
  }
}
