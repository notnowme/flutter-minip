import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/boxBorderLayout.dart';
import 'package:minip/free/views/free_index.dart';
import 'package:minip/free/views/free_read_screen.dart';
import 'package:minip/home/models/board_recent_model.dart';
import 'package:minip/home/providers/recent_provider.dart';
import 'package:minip/home/widgets/recent_card.dart';
import 'package:minip/qna/views/qna_index.dart';
import 'package:minip/qna/views/qna_read_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';
  static const String routePath = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '홈',
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(freeRecentListAsyncProvider);
            ref.refresh(qnaRecentListAsyncProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                ref.watch(freeRecentListAsyncProvider).when(
                  data: (data) {
                    if (data is RecentBoardModel) {
                      return RecentCard(
                        content: data.data,
                        boardTitle: '자유 게시판',
                        routeIndexName: FreeIndexScreen.routeName,
                        routeReadName: FreeReadScreen.routeName,
                      );
                    } else {
                      return const Center(
                        child: Text('no data...'),
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text('error'),
                    );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(
                  height: 60,
                ),
                ref.watch(qnaRecentListAsyncProvider).when(
                  data: (data) {
                    if (data is RecentBoardModel) {
                      return RecentCard(
                        content: data.data,
                        boardTitle: '질문 게시판',
                        routeIndexName: QnaIndexScreen.routeName,
                        routeReadName: QnaReadScreen.routeName,
                      );
                    } else {
                      return const BoxBorderLayout(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cancel_presentation_rounded,
                                size: 72,
                                color: thirdColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '최근 게시글이 없어요',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )),
                        ),
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text('error'),
                    );
                  },
                  loading: () {
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
