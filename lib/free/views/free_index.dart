import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/boards/widgets/no_result.dart';
import 'package:minip/common/boards/widgets/page_button.dart';
import 'package:minip/common/boards/widgets/page_num_list.dart';
import 'package:minip/common/boards/widgets/result_text.dart';
import 'package:minip/common/boards/widgets/search_bottom_sheet.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/provider/free_list_provider.dart';
import 'package:minip/free/provider/free_page_num_provider.dart';
import 'package:minip/free/views/free_search_list.dart';
import 'package:minip/free/widgets/free_content_card.dart';
import 'package:minip/free/views/free_write_screen.dart';

class FreeIndexScreen extends ConsumerStatefulWidget {
  const FreeIndexScreen({super.key});

  static const String routeName = 'free';
  static const String routePath = '/free';

  @override
  ConsumerState<FreeIndexScreen> createState() => _FreeIndexScreenState();
}

class _FreeIndexScreenState extends ConsumerState<FreeIndexScreen> {
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
    final page = ref.watch(freePageNumProvider);
    final boardDatas = ref.watch(freeListAsyncProvider(page));
    return DefaultLayout(
      title: '자유 게시판',
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: InkWell(
            onTap: () {
              // 게시글 검색 바텀시트
              SearchBottomSheet.showSearchBottomSheet(
                  context, FreeSearchListScreen.routeName);
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
          child: InkWell(
            onTap: () {
              context.pushNamed(FreeWriteScreen.routeName);
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
          ),
        ),
      ],
      child: boardDatas.when(
        data: (data) {
          if (data is FreeListModel) {
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

            return SingleChildScrollView(
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
                      return FreeContentCard(
                        data: content,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ResultText(allCounts: data.allCounts, page: page),
                  const SizedBox(
                    height: 20,
                  ),
                  PageNumList(
                    provider: freeListAsyncProvider,
                    totalPage: totalPage,
                    firstPage: firstPage,
                    lastPage: lastPage,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PageMoveButton(provider: freeListAsyncProvider),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          } else {
            return NoResult(provider: freeListAsyncProvider);
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
