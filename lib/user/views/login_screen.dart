import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/home/views/home_screen.dart';
import 'package:minip/user/models/login_req_model.dart';
import 'package:minip/user/models/login_res_model.dart';
import 'package:minip/user/provider/login_provider.dart';
import 'package:minip/user/views/join_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login';
  static const String routePath = '/login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String id = '';
  String password = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isValidated = false;

  TextEditingController passwordController = TextEditingController();

  FocusNode idFocus = FocusNode(), pwFocus = FocusNode();

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
          focusNode: idFocus,
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
          controller: passwordController,
          focusNode: pwFocus,
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
    void login() async {
      LoginReqModel user = LoginReqModel(id: id, password: password);
      Loading.showLoading(context);
      final result = await ref.read(loginAsyncProvider.notifier).login(user);
      if (mounted) {
        context.pop();
      }
      if (result is LoginResModel) {
        final storage = ref.read(secureStorageProvider);

        Future.wait([
          storage.write(key: STORAGE_USER_NO, value: result.data.no.toString()),
          storage.write(key: STORAGE_ID, value: result.data.id),
          storage.write(key: STORAGE_NICK, value: result.data.nick),
          storage.write(key: ACCESS_KEY, value: result.data.token),
        ]);

        // 이전 페이지 기억해서 보내야 될 듯.
        if (mounted) {
          ToastMessage.showToast(context, 'success', '로그인 성공했어요');
          context.goNamed(HomeScreen.routeName);
        }
      } else {
        final code = result['statusCode'];
        switch (code) {
          case 401:
            if (mounted) {
              ToastMessage.showToast(context, 'error', '비밀번호가 틀렸어요');
              passwordController.clear();
              pwFocus.requestFocus();
            }
            break;
          case 404:
            if (mounted) {
              ToastMessage.showToast(context, 'error', '아이디를 확인해 주세요');
              idFocus.requestFocus();
            }
            break;
          case 500:
            if (mounted) {
              ToastMessage.showToast(context, 'error', '서버 오류예요');
            }
            break;
        }
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (!isValidated) return;
          login();
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
            context.pushNamed(JoinScreen.routeName);
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
