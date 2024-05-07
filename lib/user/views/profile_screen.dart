import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/common/widgets/loading.dart';
import 'package:minip/common/widgets/toast.dart';
import 'package:minip/home/views/home_screen.dart';
import 'package:minip/user/models/auth_model.dart';
import 'package:minip/user/models/user_model.dart';
import 'package:minip/user/provider/join_provider.dart';
import 'package:minip/user/provider/user_data_provider.dart';
import 'package:minip/user/provider/user_detail_data_provider.dart';
import 'package:minip/user/views/login_screen.dart';
import 'package:minip/user/widgets/profile_board_info.dart';
import 'package:minip/user/widgets/profile_user_info.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({
    super.key,
  });

  static const String routeName = 'profile';
  static const String routePath = '/profile';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void dispose() {
    debugPrint('profile page dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userDataAsyncNotifier).when(
      data: (userData) {
        if (userData is UserModel) {
          return DefaultLayout(
            title: '프로필',
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(userDetailDataAsyncProvider);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          UserInfoWidget(
                            id: userData.id,
                            nick: userData.nick,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ref.watch(userDetailDataAsyncProvider).when(
                            data: (data) {
                              if (data != null) {
                                return Column(
                                  children: [
                                    BoardInfoWidget(
                                      boardName: '자유 게시판',
                                      boardCount: data.freeBoardCount,
                                      commentCount: data.freeCommentCount,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BoardInfoWidget(
                                      boardName: '질문 게시판',
                                      boardCount: data.qnaBoardCount,
                                      commentCount: data.qnaCommentCount,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    //_renderAdminButton(ref, context),
                                    _renderLogoutButton(ref, context),
                                  ],
                                );
                              } else {
                                return const Text('no data...');
                              }
                            },
                            error: (err, errStack) {
                              return GestureDetector(
                                onTap: () async {
                                  final t = ref.watch(secureStorageProvider);
                                  await t.deleteAll();
                                },
                                child: const Center(
                                  child: Text('Something error...'),
                                ),
                              );
                            },
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      _renderWithdrawButton(userData.id),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '로그인 후 이용할 수 있어요',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      LoginScreen.routeName,
                      extra: ProfileScreen.routeName,
                    );
                  },
                  child: const Text(
                    '로그인으로 이동',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
      error: (error, stackTrace) {
        print(error);
        return const Center(
          child: Text('error!'),
        );
      },
      loading: () {
        return Container();
      },
    );
  }

  Widget _renderAdminButton(WidgetRef ref, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          debugPrint('admin...');
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: inputBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: const BorderSide(
            color: thirdColor,
          ),
        ),
        child: const Text(
          '관리자 등록',
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _renderLogoutButton(WidgetRef ref, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          _showLogOutDialog();
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: inputBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: const BorderSide(
            color: thirdColor,
          ),
        ),
        child: const Text(
          '로그아웃',
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _showLogOutDialog() {
    showDialog(
      // 외부 탭 방지
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          surfaceTintColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(20),
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
                  '로그아웃할까요?',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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
                      onTap: () async {
                        final storage = ref.read(secureStorageProvider);
                        await storage.deleteAll();
                        if (context.mounted) {
                          context.pop();
                          ToastMessage.showToast(context, 'success', '로그아웃했어요');
                          ref.refresh(userDataAsyncNotifier);
                          context.goNamed(HomeScreen.routeName);
                        }
                      },
                      child: const Text(
                        '로그아웃',
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

  Widget _renderWithdrawButton(String id) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 60,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _showWithdrawDialog(id);
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: errorColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text(
            '회원 탈퇴',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  _showWithdrawDialog(String id) {
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> pwKey = GlobalKey();
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.9),
          surfaceTintColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(20),
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
                  '회원 탈퇴',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  '탈퇴 시 모든 정보가 삭제되며\n복구되지 않습니다',
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: pwKey,
                  child: CustomTextFormField(
                    controller: passwordController,
                    onChanged: (value) {},
                    validator: (value) {
                      return Validation.validatePassword(value);
                    },
                    isPassword: true,
                    hintText: '비밀번호를 입력해 주세요',
                  ),
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
                      onTap: () async {
                        if (pwKey.currentState!.validate()) {
                          await withdraw(id, passwordController.text, context);
                        }
                      },
                      child: const Text(
                        '탈퇴',
                        style: TextStyle(
                          color: errorColor,
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

  Future<void> withdraw(
      String id, String password, BuildContext context) async {
    Loading.showLoading(context);
    final result =
        await ref.read(joinAsyncProvider.notifier).checkPassword(id, password);
    if (context.mounted) {
      context.pop();
    }
    if (result is! AuthModel) {
      if (context.mounted) {
        ToastMessage.showToast(context, 'error', '비밀번호가 맞지 않아요');
      }
    } else {
      if (context.mounted) {
        Loading.showLoading(context);
        final withdrawResult =
            await ref.read(joinAsyncProvider.notifier).withdraw();

        if (withdrawResult is AuthModel) {
          debugPrint('탈퇴');
          if (context.mounted) {
            context.pop();
          }
          final storage = ref.read(secureStorageProvider);
          await storage.deleteAll();
          if (context.mounted) {
            context.pop();
            ref.refresh(userDataAsyncNotifier);
            ToastMessage.showToast(context, 'success', '탈퇴했습니다');
            context.goNamed(HomeScreen.routeName);
          }
        } else {
          print(withdrawResult);
        }
      }
    }
  }
}
