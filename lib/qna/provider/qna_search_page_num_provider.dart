import 'package:flutter_riverpod/flutter_riverpod.dart';

final qnaSearchPageNumProvider =
    AutoDisposeNotifierProvider<QnaSearchPageNumNotifier, int>(() {
  return QnaSearchPageNumNotifier();
});

class QnaSearchPageNumNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 1;
  }

  update(int page) {
    state = page;
  }
}
