import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minip/common/const/colors.dart';
import 'package:minip/qna/provider/qna_page_num_provider.dart';

class PageNumList extends ConsumerStatefulWidget {
  const PageNumList({
    super.key,
    required this.provider,
    required this.totalPage,
    required this.firstPage,
    required this.lastPage,
    required this.page,
  });

  final int totalPage;
  final AsyncNotifierProviderFamily provider;
  final int firstPage, lastPage, page;

  @override
  ConsumerState<PageNumList> createState() => _PageNumListState();
}

class _PageNumListState extends ConsumerState<PageNumList> {
  @override
  Widget build(BuildContext context) {
    final page = ref.watch(qnaPageNumProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (page == 1) {
              return;
            } else {
              ref.read(qnaPageNumProvider.notifier).update(page - 1);
              ref.refresh(widget.provider(page));
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
        for (var i = widget.firstPage; i <= widget.lastPage; i++) renderList(i),
        const SizedBox(
          width: 20,
        ),
        page < widget.totalPage
            ? GestureDetector(
                onTap: () async {
                  ref.read(qnaPageNumProvider.notifier).update(page + 1);
                  ref.refresh(widget.provider(page));
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
    final page = ref.watch(qnaPageNumProvider);
    bool isCurrent = page == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          if (isCurrent) {
            return;
          }
          ref.read(qnaPageNumProvider.notifier).update(index);
          ref.refresh(widget.provider(page));
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
