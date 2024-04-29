import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/widgets/free_content_card.dart';
import 'package:minip/qna/provider/qna_list_provider.dart';
import 'package:minip/qna/views/qna_write_screen.dart';
import 'package:minip/qna/widgets/qna_content_card.dart';

class QnaIndexScreen extends ConsumerStatefulWidget {
  const QnaIndexScreen({super.key});

  static const String routeName = 'qna';
  static const String routePath = '/qna';

  @override
  ConsumerState<QnaIndexScreen> createState() => _QnaIndexScreenState();
}

class _QnaIndexScreenState extends ConsumerState<QnaIndexScreen> {
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

  TextEditingController pageNumController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> pageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                // 작성 이동
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
                        return QnaContentCard(
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
                    renderPageNumList(totalPage),
                    const SizedBox(
                      height: 20,
                    ),
                    renderPageButton(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cancel_presentation_rounded,
                      size: 92,
                      color: thirdColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '게시물 결과가 없어요',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    renderPageButton(),
                  ],
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
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
          ref.refresh(qnaListAsyncProvider(page));
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

  Widget renderPageNumList(int totalPage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (page == 1) {
              return;
            } else {
              page = page - 1;
              ref.refresh(qnaListAsyncProvider(page));
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
                  ref.refresh(qnaListAsyncProvider(page));
                  setState(() {});
                },
                child: const Icon(
                  Icons.chevron_right_rounded,
                ),
              )
            : Container(),
      ],
    );
  }

  Widget renderPageButton() {
    return Row(
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
                5,
              ),
            ),
          ),
          onPressed: () {
            showPageBottomSheet();
          },
          child: const Text(
            '페이지 이동',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void showPageBottomSheet() {
    pageNumController.text = page.toString();
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
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  5,
                ),
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
                            '페이지 이동',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: Form(
                              key: pageKey,
                              child: CustomTextFormField(
                                controller: pageNumController,
                                isAutoFocus: true,
                                textType: TextInputType.number,
                                onChanged: (value) {},
                                validator: (value) {
                                  return Validation.validatePageMove(value);
                                },
                              ),
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
                                width: 100,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (pageKey.currentState!.validate()) {
                                    page = int.parse(pageNumController.text);
                                    ref.refresh(qnaListAsyncProvider(page));
                                    setState(() {});
                                    context.pop();
                                  }
                                },
                                child: const Text(
                                  '이동',
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
  }
}
