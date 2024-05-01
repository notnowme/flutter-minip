import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/user/models/user_nick_modify_model.dart';
import 'package:minip/user/provider/user_data_provider.dart';
import 'package:minip/user/provider/user_provider.dart';
import 'package:minip/user/views/login_screen.dart';
import 'package:minip/common/widgets/boxBorderLayout.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({
    super.key,
    required this.id,
    required this.nick,
  });

  final String id, nick;

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  TextEditingController nickController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BoxBorderLayout(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _renderAvatarIcon(),
                const SizedBox(
                  width: 10,
                ),
                _renderUserNickId(),
              ],
            ),
            IconButton(
              onPressed: () {
                _showBottomSheet();
              },
              icon: const Icon(
                Icons.create_rounded,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderAvatarIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: thirdColor,
      ),
    );
  }

  Widget _renderUserNickId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.id,
          style: const TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          widget.nick,
          style: const TextStyle(
            color: secondaryColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            27,
          ),
        ),
      ),
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            nickController.text = widget.nick;
            final storage = ref.read(secureStorageProvider);
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: textColor,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const Text(
                                '닉네임 변경',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 300,
                                child: Form(
                                  child: CustomTextFormField(
                                    controller: nickController,
                                    isAutoFocus: true,
                                    onChanged: (value) {},
                                    validator: (value) {
                                      return Validation.validateNick(value);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
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
                                    width: 100,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Loading.showLoading(context);
                                      final result = await ref
                                          .read(userAsyncProvider.notifier)
                                          .changeNick(nickController.text);
                                      if (context.mounted) {
                                        context.pop();
                                      }
                                      if (result is UserNickModifyModel) {
                                        await storage.write(
                                            key: STORAGE_NICK,
                                            value: result.data.nick);
                                        ref.refresh(userDataAsyncNotifier);
                                        if (context.mounted) {
                                          ToastMessage.showToast(
                                              context, 'success', '닉네임을 바꿨어요');
                                          context.pop();
                                        }
                                      } else {
                                        final code = result['statusCode'];
                                        switch (code) {
                                          case 401:
                                            if (context.mounted) {
                                              ToastMessage.showToast(context,
                                                  'error', '다시 로그인해 주세요');
                                              await storage.deleteAll();
                                              if (context.mounted) {
                                                context.goNamed(
                                                    LoginScreen.routeName);
                                              }
                                            }
                                            break;
                                          case 409:
                                            if (context.mounted) {
                                              ToastMessage.showToast(context,
                                                  'error', '이미 있는 닉네임이에요');
                                            }
                                            break;
                                          case 500:
                                            if (context.mounted) {
                                              ToastMessage.showToast(
                                                  context, 'error', '서버 오류');
                                            }
                                            break;
                                        }
                                      }
                                    },
                                    child: const Text(
                                      '변경',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
