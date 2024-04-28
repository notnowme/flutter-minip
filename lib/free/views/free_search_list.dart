import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
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
      title: '자유 게시판',
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
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cancel_presentation_rounded,
                        size: 92,
                        color: thirdColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '게시물 결과가 없어요',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // renderPageButton(),
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
}
