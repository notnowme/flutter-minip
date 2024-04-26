import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/free/provider/free_search_list_provider.dart';

class FreeSearchListScreen extends ConsumerStatefulWidget {
  const FreeSearchListScreen({super.key});

  static const String routeName = 'freeSearch';
  static const String routePath = 'search';

  @override
  ConsumerState<FreeSearchListScreen> createState() =>
      _FreeSearchListScreenState();
}

class _FreeSearchListScreenState extends ConsumerState<FreeSearchListScreen> {
  String currentCategory = 'title';
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '자유 게시판',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                renderCategoriesButton('제목', currentCategory == 'title'),
                renderCategoriesButton('내용', currentCategory == 'content'),
                renderCategoriesButton('작성자', currentCategory == 'author'),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                // final result = ref.read(freeSearchListAsyncProvider().notifier).getLists(board, cat, keyword, page)
              },
              child: const Text(
                'ㅌㅅㅌ',
              ),
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
              currentCategory = 'author';
              break;
          }
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
