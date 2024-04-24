import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/providers/secure_storage.dart';
import 'package:minip/user/provider/user_data_provider.dart';
import 'package:minip/user/views/login_screen.dart';
import 'package:minip/user/widgets/profile_board_info.dart';
import 'package:minip/user/widgets/profile_user_info.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

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
      data: (data) {
        if (data == null) {
          return const Center(
            child: Text('error'),
          );
        } else {
          return DefaultLayout(
            title: '프로필',
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      UserInfoWidget(
                        id: data.id,
                        nick: data.nick,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const BoardInfoWidget(
                        boardName: '자유 게시판',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const BoardInfoWidget(
                        boardName: '질문 게시판',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _renderLogoutButton(ref, context),
                    ],
                  ),
                  _renderWithdrawButton(),
                ],
              ),
            ),
          );
        }
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text('error!'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _renderLogoutButton(WidgetRef ref, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          _showDialog();
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: inputBgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: const BorderSide(
              color: thirdColor,
            )),
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

  void _showDialog() {
    showDialog(
      // 외부 탭 방지
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (_) {
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
                        if (mounted) {
                          context.pop();
                          context.goNamed(LoginScreen.routeName);
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

  Widget _renderWithdrawButton() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 60,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
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
}
