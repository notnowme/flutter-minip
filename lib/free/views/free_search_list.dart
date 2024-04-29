import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/const/data.dart';
import 'package:minip/common/hooks/validation.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/common/widgets/custom_text_formField.dart';
import 'package:minip/free/models/free_list_model.dart';
import 'package:minip/free/models/free_search_model.dart';
import 'package:minip/free/provider/free_search_list_provider.dart';
import 'package:minip/free/widgets/free_content_card.dart';

class FreeSearchListScreen extends ConsumerStatefulWidget {
  const FreeSearchListScreen({super.key, this.extra});

  static const String routeName = 'freeSearch';
  static const String routePath = 'search';
  final Object? extra;

  @override
  ConsumerState<FreeSearchListScreen> createState() =>
      _FreeSearchListScreenState();
}

class _FreeSearchListScreenState extends ConsumerState<FreeSearchListScreen> {
  String currentCategory = 'title';
  late FreeSearchModel form;
  int pageGroup = 0;
  int firstPage = 0;
  int lastPage = 0;
  int nextPage = 0;
  int prevPage = 0;
  TextEditingController pageNumController = TextEditingController();
  GlobalKey<FormState> pageKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    form = FreeSearchModel(
      board: 'free',
      cat: currentCategory,
      keyword: widget.extra as String,
      page: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchResult = ref.watch(freeSearchListAsyncProvider(form));
    return DefaultLayout(
      title: '자유 게시판 검색',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                renderCategoriesButton('제목', currentCategory == 'title'),
                renderCategoriesButton('내용', currentCategory == 'content'),
                renderCategoriesButton('작성자', currentCategory == 'nick'),
              ],
            ),
            searchResult.when(
              data: (data) {
                if (data is FreeListModel) {
                  // 페이징
                  int totalPage = (data.boardsCount / 20).ceil();

                  pageGroup = (form.page / PAGE_COUNT).ceil();

                  lastPage = pageGroup * PAGE_COUNT > totalPage
                      ? totalPage
                      : pageGroup * PAGE_COUNT;

                  firstPage = lastPage - (PAGE_COUNT - 1) <= 0
                      ? 1
                      : lastPage - (PAGE_COUNT - 1);

                  nextPage =
                      lastPage + 1 > totalPage ? totalPage : lastPage + 1;

                  prevPage = firstPage - 1 <= 0 ? 1 : firstPage - 1;

                  return Column(
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
                              '검색된 ${data.boardsCount}개의 게시글 중 ${form.page}번째 페이지',
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
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
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
              error: (err, errStack) {
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
          ],
        ),
      ),
    );
  }

  Widget renderCategoriesButton(String label, bool isSelected) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          switch (label) {
            case '제목':
              currentCategory = 'title';
              break;
            case '내용':
              currentCategory = 'content';
              break;
            case '작성자':
              currentCategory = 'nick';
              break;
          }
          form = form.copywith(cat: currentCategory);
          ref.refresh(freeSearchListAsyncProvider(form));
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? textColor : secondaryColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : thirdColor,
              ),
            ),
          ],
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
            if (form.page == 1) {
              return;
            } else {
              form = form.copywith(page: form.page - 1);
              ref.refresh(freeSearchListAsyncProvider(form));
              setState(() {});
            }
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: form.page == 1 ? thirdColor : textColor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        for (var i = firstPage; i <= lastPage; i++) renderList(i),
        const SizedBox(
          width: 20,
        ),
        form.page < totalPage
            ? GestureDetector(
                onTap: () async {
                  form = form.copywith(page: form.page + 1);
                  ref.refresh(freeSearchListAsyncProvider(form));
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

  Widget renderList(int index) {
    bool isCurrent = form.page == index;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: GestureDetector(
        onTap: () {
          if (isCurrent) {
            return;
          }
          form = form.copywith(page: index);
          ref.refresh(freeSearchListAsyncProvider(form));
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
    pageNumController.text = form.page.toString();
    showModalBottomSheet(
      useRootNavigator: false,
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
                                    context.pop();
                                    form = form.copywith(
                                        page:
                                            int.parse(pageNumController.text));
                                    ref.refresh(
                                        freeSearchListAsyncProvider(form));
                                    setState(() {});
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
