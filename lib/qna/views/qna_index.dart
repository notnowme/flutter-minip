import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/content_card.dart';
import 'package:minip/common/boards/widgets/result_text.dart';
import 'package:minip/common/boards/widgets/search_bottom_sheet.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/qna/provider/qna_list_provider.dart';
import 'package:minip/qna/provider/qna_page_num_provider.dart';
import 'package:minip/qna/views/qna_read_screen.dart';
import 'package:minip/qna/views/qna_search_list.dart';
import 'package:minip/qna/views/qna_write_screen.dart';
import 'package:minip/qna/widgets/no_result.dart';
import 'package:minip/qna/widgets/page_num_list.dart';
import 'package:minip/qna/widgets/page_button.dart';
import 'package:minip/user/provider/user_data_provider.dart';
import 'package:minip/user/views/login_screen.dart';

class QnaIndexScreen extends ConsumerStatefulWidget {
  const QnaIndexScreen({super.key});

  static const String routeName = 'qna';
  static const String routePath = '/qna';

  @override
  ConsumerState<QnaIndexScreen> createState() => _QnaIndexScreenState();
}

class _QnaIndexScreenState extends ConsumerState<QnaIndexScreen> {
  int pageGroup = 0;
  int firstPage = 0;
  int lastPage = 0;
  int nextPage = 0;
  int prevPage = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(qnaPageNumProvider);
    final boardDatas = ref.watch(qnaListAsyncProvider(page));
    return DefaultLayout(
      title: '질문 게시판',
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: InkWell(
            onTap: () {
              // 검색 바텀시트
              SearchBottomSheet.showSearchBottomSheet(
                context,
                QnaSearchListScreen.routeName,
              );
            },
            splashColor: Colors.grey[300],
            borderRadius: BorderRadius.circular(50),
            child: const SizedBox(
              width: 32,
              height: 32,
              child: Icon(
                Icons.search_rounded,
                size: 24,
                color: secondaryColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: ref.watch(userDataAsyncNotifier).when(
            data: (data) {
              if (data == null) {
                return InkWell(
                  onTap: () {
                    context.pushNamed(
                      LoginScreen.routeName,
                      extra: QnaIndexScreen.routeName,
                    );
                  },
                  splashColor: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                  child: const SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(
                      Icons.login_rounded,
                      size: 24,
                      color: primaryColor,
                    ),
                  ),
                );
              } else {
                return InkWell(
                  onTap: () {
                    context.pushNamed(QnaWriteScreen.routeName);
                  },
                  splashColor: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                  child: const SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(
                      Icons.create_rounded,
                      size: 24,
                      color: primaryColor,
                    ),
                  ),
                );
              }
            },
            error: (error, stackTrace) {
              return null;
            },
            loading: () {
              return null;
            },
          ),
        ),
      ],
      child: boardDatas.when(
        data: (data) {
          if (data is FreeListModel) {
            ScrollController scrollController = ScrollController();
            int totalPage = (data.allCounts / 20).ceil();

            pageGroup = (page / PAGE_COUNT).ceil();

            lastPage = pageGroup * PAGE_COUNT > totalPage
                ? totalPage
                : pageGroup * PAGE_COUNT;

            firstPage = lastPage - (PAGE_COUNT - 1) <= 0
                ? 1
                : lastPage - (PAGE_COUNT - 1);

            nextPage = lastPage + 1 > totalPage ? totalPage : lastPage + 1;

            prevPage = firstPage - 1 <= 0 ? 1 : firstPage - 1;

            return RefreshIndicator(
              onRefresh: () async {
                ref.refresh(qnaListAsyncProvider(1));
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.data.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 0,
                        );
                      },
                      itemBuilder: (context, index) {
                        var content = data.data[index];
                        return ContentCard(
                          data: content,
                          routeName: QnaReadScreen.routeName,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ResultText(
                      allCounts: data.allCounts,
                      page: page,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PageNumList(
                      provider: qnaListAsyncProvider,
                      totalPage: totalPage,
                      firstPage: firstPage,
                      lastPage: lastPage,
                      page: page,
                      scroller: scrollController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    PageMoveButton(
                      provider: qnaListAsyncProvider,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return NoResult(
              provider: qnaListAsyncProvider,
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
    );
  }
}
