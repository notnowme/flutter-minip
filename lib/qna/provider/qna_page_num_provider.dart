import 'package:flutter_riverpod/flutter_riverpod.dart';

final qnaPageNumProvider =
    AutoDisposeNotifierProvider<QnaPageNumNotifier, int>(() {
  return QnaPageNumNotifier();
});

class QnaPageNumNotifier extends AutoDisposeNotifier<int> {
  @override
  int build() {
    return 1;
  }

  update(int page) {
    state = page;
  }
}
