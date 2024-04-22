import 'package:flutter/material.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/user/widgets/profile_board_info.dart';
import 'package:minip/user/widgets/profile_user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const UserInfoWidget(),
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
                _renderLogoutButton(),
              ],
            ),
            _renderWithdrawButton(),
          ],
        ),
      ),
    );
  }

  Widget _renderLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
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
