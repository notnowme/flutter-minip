import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/free/provider/free_list_provider.dart';
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
  late int page;
  int pageGroup = 0;
  int firstPage = 0;
  int lastPage = 0;
  int nextPage = 0;
  int prevPage = 0;
  @override
  void initState() {
    super.initState();
    page = 1;
  }

  @override
  Widget build(BuildContext context) {
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
        )
      ],
      child: boardDatas.when(
        data: (data) {
          if (data.ok) {
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
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${data.allCounts}개의 게시글 중 $page번째 페이지',
                          style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (page == 1) {
                            return;
                          } else {
                            page = page - 1;
                            ref.refresh(freeListAsyncProvider(page));
                            setState(() {});
                          }
                        },
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: page == 1 ? thirdColor : textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      for (var i = firstPage; i <= lastPage; i++) renderList(i),
                      const SizedBox(
                        width: 20,
                      ),
                      page < totalPage
                          ? GestureDetector(
                              onTap: () async {
                                page = page + 1;
                                ref.refresh(freeListAsyncProvider(page));
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.chevron_right_rounded,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: inputBgColor,
                          side: const BorderSide(
                            width: 1,
                            color: thirdColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          '검색',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
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
            );
          } else {
            return const Center(
              child: Text('wrong'),
            );
          }
        },
        error: (error, stackTrace) {
          print(error);
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

  Widget renderList(int index) {
    bool isCurrent = page == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          if (isCurrent) {
            return;
          }
          page = index;
          ref.refresh(freeListAsyncProvider(page));
          setState(() {});
        },
        child: Text(
          '$index',
          style: TextStyle(
            color: isCurrent ? primaryColor : textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
